require 'spec_helper'

if Puppet::Util::Package.versioncmp(Puppet.version, '4.10.0') >= 0
  describe 'Autofs::MountOptions' do
    describe 'accepts any string that starts with hyphen' do
      [
        '-fstype=cifs,rw,vers=3.0,sec=ntlmssp,gid=rehan,uid=rehan,file_mode=0777,dir_mode=0777',
        '-fstype=cifs,rw,vers=3.0,sec=ntlmssp',
      ].each do |value|
        describe value.inspect do
          it { is_expected.to allow_value(value) }
        end
      end
    end

    describe 'rejects other values' do
      [
        [],
        {},
        'abc1',
        true,
        'atun1000',
      ].each do |value|
        describe value.inspect do
          it { is_expected.not_to allow_value(value) }
        end
      end
    end
  end
end
