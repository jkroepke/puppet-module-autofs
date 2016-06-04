require 'spec_helper'

describe 'autofs::mount' do
  let(:title) { '/mnt/foo' }
  let(:facts) {{ :osfamily => 'RedHat', :concat_basedir => '/mock_dir' }}

  describe 'passing something other than present, absent, or purged for ensure' do
      let(:params) {{ :mapfile => 'auto.foo' , :map => 'nfsserver:/nfs/share', :ensure => 'foo' }}
      it { should raise_error(Puppet::Error, /ensure must be one of/) }
  end

  describe 'passing present for ensure' do
      let(:params) {{ :mapfile => 'auto.foo' , :map => 'nfsserver:/nfs/share', :ensure => 'present' }}
      it { should_not raise_error }
      it {
          should contain_concat__fragment('/mnt/foo@auto.foo').
          with_content(/\/\/mnt\/foo  nfsserver:\/nfs\/share/)
      }
      it {
          should contain_concat('auto.foo').
          with_ensure('present')
      }
  end

  describe 'passing absent for ensure' do
      let(:params) {{ :mapfile => 'auto.foo' , :map => 'nfsserver:/nfs/share' , :ensure => 'absent' }}
      it { should_not raise_error }
      it {
          should_not contain_concat__fragment('/mnt/foo@auto.foo')
          should_not contain_autofs__mapfile('auto.foo')
      }
  end

  describe 'testing parameter options' do
      let(:params) {{ :mapfile => 'auto.foo' , :map => 'nfsserver:/nfs/share' , :options => 'rw' , :ensure => 'present' }}
      it { should_not raise_error }
      it {
          should contain_concat__fragment('/mnt/foo@auto.foo').
          with_content(/\/\/mnt\/foo rw nfsserver:\/nfs\/share/)
      }
  end

  describe 'testing parameter order' do
      let(:params) {{ :mapfile => 'auto.foo' , :map => 'nfsserver:/nfs/share' , :order => '5' , :ensure => 'present' }}
      it { should_not raise_error }
      it {
          should contain_concat__fragment('/mnt/foo@auto.foo').
          with_order('5')
      }
  end

  describe 'testing if autofs::mapfile is present' do
      let(:params) {{ :mapfile => 'auto.foo' , :map => 'nfsserver:/nfs/share' , :order => '5' , :ensure => 'present' }}
      it { should_not raise_error }
      it {
        should contain_autofs__mapfile('auto.foo')
      }
  end
end

