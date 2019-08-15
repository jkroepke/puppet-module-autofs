# To check the correct dependancies are set up for autofs.

require 'spec_helper'
describe 'autofs' do
  let(:facts) { {} }

  let :pre_condition do
    'file { "foo.rb":
      ensure => present,
      path => "/etc/tmp",
      notify => Service["autofs"] }'
  end

  on_supported_os.each do |os, f|
    context "on #{os}" do
      let(:facts) do
        f.merge(super())
      end

      it { is_expected.to compile.with_all_deps }
      describe 'Testing the dependancies between the classes' do
        it { is_expected.to contain_class('autofs::install') }
        it { is_expected.to contain_class('autofs::config') }
        it { is_expected.to contain_class('autofs::service') }
        it { is_expected.to contain_class('autofs::install').that_comes_before('Class[autofs::config]') }
        it { is_expected.to contain_class('autofs::service').that_subscribes_to('Class[autofs::config]') }
        it { is_expected.to contain_file('foo.rb').that_notifies('Service[autofs]') }
      end
    end
  end
end
