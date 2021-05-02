require 'spec_helper'

on_supported_os.each do |os, f|
  describe 'autofs' do
    let(:facts) { {} }

    let(:conf_path) do
      if os.match?(%r{archlinux|gentoo})
        '/etc/autofs/'
      else
        '/etc/'
      end
    end

    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      context 'with defaults' do
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('autofs::install') }
        it { is_expected.to contain_class('autofs::config') }
        it { is_expected.to contain_class('autofs::service') }

        if os.include?('gentoo')
          it { is_expected.to contain_package('net-fs/autofs') }
        else
          it { is_expected.to contain_package('autofs') }
        end

        if os.include?('debian')
          it { is_expected.to contain_package('autofs-ldap') }
        end

        it { is_expected.to contain_autofs__mapfile('auto.master') }
        it { is_expected.to contain_service('autofs') }

        it { is_expected.to contain_concat('auto.master').with_path(conf_path + 'auto.master').with_owner('root') }
        it { is_expected.to contain_file(conf_path + 'autofs.conf').with_owner('root').with_content(%r{timeout = 300}) }
      end

      context 'without package management' do
        let(:params) do
          {
            package_manage: false,
          }
        end

        it { is_expected.not_to contain_package('autofs') }
      end

      context 'without service management' do
        let(:params) do
          {
            service_manage: false,
          }
        end

        it { is_expected.not_to contain_service('autofs') }
      end

      context 'with parameter master_map_name' do
        let(:params) do
          {
            master_map_name: 'auto.master',
          }
        end

        it { is_expected.to contain_file(conf_path + 'autofs.conf').with_content(%r{master_map_name = auto\.master}) }
      end

      context 'with parameter umount_wait' do
        let(:params) do
          {
            umount_wait: 12,
          }
        end

        it { is_expected.to contain_file(conf_path + 'autofs.conf').with_content(%r{umount_wait = 12}) }
      end

      context 'with parameter browse_mode' do
        let(:params) do
          {
            browse_mode: true,
          }
        end

        it { is_expected.to contain_file(conf_path + 'autofs.conf').with_content(%r{browse_mode = yes}) }
      end

      context 'with parameter amd' do
        let(:params) do
          {
            amd: {
              key: 'value',
              browse_mode: true,
            },
          }
        end

        it { is_expected.to contain_file(conf_path + 'autofs.conf').with_content(%r{\[ amd \]\nkey = value\nbrowse_mode = yes}) }
      end

      context 'with parameter custom_config' do
        let(:params) do
          {
            custom_config: {
              "/mnt/example": {
                key: 'value',
                browse_mode: true,
              },
            },
          }
        end

        it { is_expected.to contain_file(conf_path + 'autofs.conf').with_content(%r{\[ /mnt/example \]\nkey = value\nbrowse_mode = yes}) }
      end
    end
  end
end
