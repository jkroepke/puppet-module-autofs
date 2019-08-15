# Class: autofs

class autofs (
  String                                        $config_file_owner,
  String                                        $config_file_group,
  String                                        $master_config,
  Stdlib::Absolutepath                          $map_config_dir,
  Array[String]                                 $supported_map_types,
  Boolean                                       $use_map_prefix,
  Boolean                                       $package_manage,
  Array[String]                                 $package_name,
  String                                        $package_ensure,
  String                                        $service_name,
  Boolean                                       $service_manage,
  Enum['running', 'stopped']                    $service_ensure,
  Boolean                                       $service_enable,
  Boolean                                       $service_hasrestart,
  Boolean                                       $service_hasstatus,
  Optional[String]                              $service_restart,

  Optional[String[1]]                           $master_map_name = undef,
  Optional[Integer]                             $timeout = undef,
  Optional[Integer]                             $negative_timeout = undef,
  Optional[Integer]                             $mount_wait = undef,
  Optional[Integer]                             $umount_wait = undef,
  Optional[Variant[Boolean, Enum['yes', 'no']]] $browse_mode = undef,
  Optional[Integer]                             $mount_nfs_default_protocol = undef,
  Optional[Variant[Boolean, Enum['yes', 'no']]] $append_options = undef,
  Optional[Enum['none','verbose','debug']]      $logging = undef,
  Optional[Variant[Boolean, Enum['yes', 'no']]] $force_standard_program_map_env = undef,
  Optional[String[1]]                           $ldap_uri = undef,
  Optional[Integer]                             $ldap_timeout = undef,
  Optional[Integer]                             $ldap_network_timeout = undef,
  Optional[String[1]]                           $search_base = undef,

  Optional[String[1]]                           $map_object_class = undef,
  Optional[String[1]]                           $entry_object_class = undef,
  Optional[String[1]]                           $map_attribute = undef,
  Optional[String[1]]                           $entry_attribute = undef,
  Optional[String[1]]                           $value_attribute = undef,
  Optional[String[1]]                           $auth_conf_file = undef,
  Optional[Integer]                             $map_hash_table_size = undef,
  Optional[Variant[Boolean, Enum['yes', 'no']]] $use_hostname_for_mounts = undef,
  Optional[Variant[Boolean, Enum['yes', 'no']]] $disable_not_found_message = undef,

  Hash                                          $amd = {},

  Hash[String, Hash]                            $mapfiles      = {},
  Hash[String, Hash]                            $mounts        = {},
  Hash[String, Hash]                            $includes      = {},

  Autofs::Config                                $custom_config = {},

) {
  contain autofs::install
  contain autofs::config
  contain autofs::service

  Class['autofs::install']
  -> Class['autofs::config']
  ~> Class['autofs::service']
}
