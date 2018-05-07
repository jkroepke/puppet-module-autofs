require 'spec_helper_acceptance'

describe 'autofs class:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'autofs is expected run successfully' do
    pp = "class { 'autofs': }"

    # Apply twice to ensure no errors the second time.
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to match(%r{error}i)
    end
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to eq(%r{error}i)

      expect(r.exit_code).to be_zero
    end
  end

  context 'package_ensure => present:' do
    it 'runs successfully to ensure package is installed' do
      pp = "class { 'autofs': package_ensure => present }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end

  context 'create and test mount for a ramdisk:' do
    it 'runs successfully to create and test mount for a ramdisk' do
      shell('mkdir -p /media/ramdisk')

      pp = %q(
        class { 'autofs':
          package_ensure => present,
          mapfiles => {
            'auto.ramdisk' => {
              directory => '/-',
            }
          },
          mounts => {
            '/ramdisk' => {
              mapfile => 'auto.ramdisk',
              options => '-fstype=tmpfs,size=32M',
              map => '/media/ramdisk',
            }
          }
        }
      )

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
      shell('test -e /ramdisk')
    end
  end

  context 'service_ensure => running:' do
    it 'starts the service successfully' do
      pp = "class { 'autofs': service_ensure => running }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end

  context 'service_ensure => stopped:' do
    it 'stops the service successfully' do
      pp = "class { 'autofs': service_ensure => stopped }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end

  context 'package_ensure => absent:' do
    it 'runs successfully to ensure package is uninstalled' do
      pp = "class { 'autofs': package_ensure => absent, service_manage => false, }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end
    end
  end
end
