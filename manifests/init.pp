# Class: autofs

class autofs (
  String $config_file_owner            = $autofs::params::config_file_owner,
  String $config_file_group            = $autofs::params::config_file_group,
  String $master_config                = $autofs::params::master_config,
  Stdlib::Absolutepath $map_config_dir = $autofs::params::map_config_dir,
  Boolean $package_manage              = $autofs::params::package_manage,
  Array[String] $package_name          = $autofs::params::package_name,
  String $package_ensure               = $autofs::params::package_ensure,
  String $service_name                 = $autofs::params::service_name,
  Boolean $service_manage              = $autofs::params::service_manage,
  Boolean $service_hasrestart          = $autofs::params::service_hasrestart,
  Boolean $service_hasstatus           = $autofs::params::service_hasstatus,
  Variant[Enum[running, stopped], Boolean]
  $service_ensure                      = $autofs::params::service_ensure,
  Boolean $service_enable              = $autofs::params::service_enable,
  Optional[String] $service_restart    = $autofs::params::service_restart,
  Hash $mapfiles                       = {},
  Hash $mounts                         = {},
  Hash $includes                       = {},
) inherits autofs::params {

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'autofs::begin': }
  -> class { '::autofs::install': }
  -> class { '::autofs::config': }
  ~> class { '::autofs::service': }
  -> anchor { 'autofs::end': }
}
