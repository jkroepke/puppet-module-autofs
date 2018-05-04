require 'spec_helper'

describe 'autofs::mount' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:title) { '/mnt/foo' }

      describe 'passing something other than present, absent, or purged for ensure' do
        let(:params) { { mapfile: 'auto.foo', map: 'nfsserver:/nfs/share', ensure: 'foo' } }

        it { is_expected.to raise_error(Puppet::Error) }
      end

      describe 'passing present for ensure' do
        let(:params) { { mapfile: 'auto.foo', map: 'nfsserver:/nfs/share', ensure: 'present' } }

        it { is_expected.not_to raise_error }
        it do
          is_expected.to contain_concat__fragment('/mnt/foo@auto.foo').with(
            'content' => %r{/mnt/foo -rw nfsserver:/nfs/share},
          )
        end
      end

      describe 'passing absent for ensure' do
        let(:params) { { mapfile: 'auto.foo', map: 'nfsserver:/nfs/share', ensure: 'absent' } }

        it { is_expected.not_to raise_error }
        it do
          is_expected.not_to contain_concat__fragment('/mnt/foo@auto.foo')
        end
      end

      describe 'testing parameter options' do
        let(:params) { { mapfile: 'auto.foo', map: 'nfsserver:/nfs/share', options: '-ro', ensure: 'present' } }

        it { is_expected.not_to raise_error }
        it do
          is_expected.to contain_concat__fragment('/mnt/foo@auto.foo').with(
            'content' => %r{/mnt/foo -ro nfsserver:/nfs/share},
          )
        end
      end

      describe 'testing parameter order' do
        let(:params) { { mapfile: 'auto.foo', map: 'nfsserver:/nfs/share', order: '5', ensure: 'present' } }

        it { is_expected.not_to raise_error }
        it do
          is_expected.to contain_concat__fragment('/mnt/foo@auto.foo').with(
            'order' => '5',
          )
        end
      end
    end
  end
end
