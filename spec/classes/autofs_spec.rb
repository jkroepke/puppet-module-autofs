require 'spec_helper'

describe 'autofs', type: :class do
  let(:facts) do
    {
      os: { family: 'Debian', name: 'Debian', release: { major: '8', full: '8.0' } },
      lsbdistid: 'Debian',
      osfamily: 'Debian',
      lsbdistcodename: 'jessie',
    }
  end

  context 'with defaults' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('autofs::install') }
    it { is_expected.to contain_class('autofs::config') }
    it { is_expected.to contain_class('autofs::service') }

    it { is_expected.to contain_package('autofs-ldap') }
    it { is_expected.to contain_autofs__mapfile('auto.master') }
    it { is_expected.to contain_service('autofs') }

    it { is_expected.to contain_concat('auto.master').with_path('/etc/auto.master').with_owner('root') }
  end

  context 'without package management' do
    let(:params) do
      {
        package_manage: false,
      }
    end

    it { is_expected.not_to contain_package('autofs-ldap') }
  end

  context 'without service management' do
    let(:params) do
      {
        service_manage: false,
      }
    end

    it { is_expected.not_to contain_service('autofs') }
  end
end
