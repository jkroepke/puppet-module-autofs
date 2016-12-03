require 'spec_helper'

describe 'autofs::mapfile' do
  let(:title) { 'auto.foo' }
  let(:facts) { { osfamily: 'RedHat', concat_basedir: '/mock_dir' } }

  describe 'passing something other than present, absent, or purged for ensure' do
    let(:params) { { directory: '/foo', ensure: 'foo' } }
    it { is_expected.to raise_error(Puppet::Error, %r{ensure must be one of}) }
  end

  describe 'passing present for ensure' do
    let(:params) { { directory: '/foo', ensure: 'present' } }
    it { is_expected.not_to raise_error }
    it do
      is_expected.to contain_concat__fragment('auto.master/auto.foo').
        with_content(%r{/foo auto.foo})
    end
    it do
      is_expected.to contain_concat('auto.foo').
        with_ensure('present')
    end
  end

  describe 'passing absent for ensure' do
    let(:params) { { directory: '/foo', ensure: 'absent' } }
    it { is_expected.not_to raise_error }
    it do
      is_expected.not_to contain_concat__fragment('auto.master/auto.foo')
    end
    it do
      is_expected.to contain_concat('auto.foo').
        with_ensure('absent')
    end
  end

  describe 'passing purged for ensure' do
    let(:params) { { directory: '/foo', ensure: 'purged' } }
    it { is_expected.not_to raise_error }
    it do
      is_expected.not_to contain_concat__fragment('auto.master/auto.foo')
    end
    it do
      is_expected.to contain_concat('auto.foo').
        with_ensure('absent')
    end
    it do
      is_expected.to contain_file('/foo').with(
        ensure: 'absent',
        force: true
      )
    end
  end

  describe 'with an invalid map type' do
    let(:params) { { directory: '/foo', maptype: 'bar' } }
    it { is_expected.to raise_error(Puppet::Error, %r{maptype must be one of}) }
  end

  describe 'with a different map type' do
    let(:params) { { directory: '/foo', maptype: 'program' } }
    it { is_expected.not_to raise_error }
    it do
      is_expected.to contain_concat__fragment('auto.master/auto.foo').
        with_content(%r{program:auto.foo})
    end
    it do
      is_expected.not_to contain_concat('auto.foo')
    end
  end
end
