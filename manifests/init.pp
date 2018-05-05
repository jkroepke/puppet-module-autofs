# Class: autofs

class autofs (
  String $config_file_owner,
  String $config_file_group,
  String $master_config,
  Stdlib::Absolutepath $map_config_dir,
  Array[String] $supported_map_types,
  Boolean $use_map_prefix,
  Boolean $package_manage,
  Array[String] $package_name,
  String $package_ensure,
  String $service_name,
  Boolean $service_manage,
  Variant[Enum[running, stopped], Boolean] $service_ensure,
  Boolean $service_enable,
  Boolean $service_hasrestart,
  Boolean $service_hasstatus,
  Optional[String] $service_restart,
  Hash $mapfiles = {},
  Hash $mounts   = {},
  Hash $includes = {},
) {

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'autofs::begin': }
  -> class { '::autofs::install': }
  -> class { '::autofs::config': }
  ~> class { '::autofs::service': }
  -> anchor { 'autofs::end': }
}
