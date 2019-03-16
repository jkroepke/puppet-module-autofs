#
define autofs::mount(
  String                $mapfile,
  String                $map,
  String                $mount   = $title,
  Enum[present, absent] $ensure  = present,
  Autofs::MountOptions  $options = '-rw',
  Optional[String]      $order   = undef,
) {
  include autofs

  if $mapfile == $autofs::master_config {
    fail("You can't add mounts directly to ${autofs::map_config_dir}/${autofs::master_config}!")
  }

  if $ensure == 'present' {
    concat::fragment { "${mount}@${mapfile}":
      target  => $mapfile,
      content => "${mount} ${options} ${map}",
      order   => $order;
    }
  }
}
