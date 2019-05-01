require 'spec_helper'

describe 'autofs::mapfile' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:title) { 'auto.foo' }

      describe 'passing something other than present, absent, or purged for ensure' do
        let(:params) { { directory: '/foo', ensure: 'foo' } }

        it { is_expected.to raise_error(Puppet::Error) }
      end

      describe 'passing present for ensure' do
        let(:params) { { directory: '/foo', ensure: 'present' } }

        it { is_expected.not_to raise_error }
        it do
          is_expected.to contain_concat__fragment('auto.master/auto.foo')
            .with_content(%r{/foo auto.foo})
        end
        it do
          is_expected.to contain_concat('auto.foo')
            .with_ensure('present')
        end
      end

      describe 'passing foo as maptype should fail' do
        let(:params) { { directory: '/foo', maptype: 'foo' } }

        it { is_expected.to raise_error(Puppet::Error) }
      end

      describe 'passing file as maptype should pass' do
        let(:params) { { directory: '/foo', maptype: 'file' } }

        it { is_expected.not_to raise_error }
        it do
          is_expected.to contain_concat__fragment('auto.master/auto.foo')
            .with_content(%r{/foo auto.foo})
        end
        it do
          is_expected.to contain_concat('auto.foo')
            .with_ensure('present')
        end
      end

      describe 'passing absent for ensure' do
        let(:params) { { directory: '/foo', ensure: 'absent' } }

        it { is_expected.not_to raise_error }
        it do
          is_expected.not_to contain_concat__fragment('auto.master/auto.foo')
        end
        it do
          is_expected.to contain_concat('auto.foo')
            .with_ensure('absent')
        end
      end

      describe 'passing purged for ensure' do
        let(:params) { { directory: '/foo', ensure: 'purged' } }

        it { is_expected.not_to raise_error }
        it do
          is_expected.not_to contain_concat__fragment('auto.master/auto.foo')
        end
        it do
          is_expected.to contain_concat('auto.foo')
            .with_ensure('absent')
        end
        it do
          is_expected.to contain_file('/foo').with(
            ensure: 'absent',
            force: true,
          )
        end
      end

      describe 'with an invalid map type' do
        let(:params) { { directory: '/foo', maptype: 'bar' } }

        it { is_expected.to raise_error(Puppet::Error) }
      end

      describe 'with a different map type' do
        let(:params) { { directory: '/foo', maptype: 'program' } }

        it { is_expected.not_to raise_error }
        it do
          is_expected.to contain_concat__fragment('auto.master/auto.foo')
            .with_content(%r{program:auto.foo})
        end
        it do
          is_expected.not_to contain_concat('auto.foo')
        end
      end
    end
  end
end
