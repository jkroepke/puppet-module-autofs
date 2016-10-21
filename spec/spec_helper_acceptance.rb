require 'beaker-rspec'

hosts.each do |host|
  # Install Puppet
  on host, install_puppet
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  # This is where we 'setup' the nodes before running our tests
  c.before :suite do
    hosts.each do |host|
      # Install module
      copy_module_to(host, source: proj_root, module_name: 'autofs')
      on host, puppet('module', 'install', 'puppetlabs-stdlib'), acceptable_exit_codes: [0, 1]
      on host, puppet('module', 'install', 'puppetlabs-concat'), acceptable_exit_codes: [0, 1]
    end
  end
end
