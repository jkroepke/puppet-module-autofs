# Class: autofs

class autofs (
  String                     $config_file_owner,
  String                     $config_file_group,
  String                     $master_config,
  Stdlib::Absolutepath       $map_config_dir,
  Array[String]              $supported_map_types,
  Boolean                    $use_map_prefix,
  Boolean                    $package_manage,
  Array[String]              $package_name,
  String                     $package_ensure,
  String                     $service_name,
  Boolean                    $service_manage,
  Enum['running', 'stopped'] $service_ensure,
  Boolean                    $service_enable,
  Boolean                    $service_hasrestart,
  Boolean                    $service_hasstatus,
  Optional[String]           $service_restart,
  Hash                       $mapfiles = {},
  Hash                       $mounts   = {},
  Hash                       $includes = {},
) {
  contain autofs::install
  contain autofs::config
  contain autofs::service

  Class['::autofs::install']
  -> Class['::autofs::config']
  ~> Class['::autofs::service']
}
