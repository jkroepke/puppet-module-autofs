#
define autofs::mapfile (
  Optional[Stdlib::Absolutepath] $directory,
  Enum[present, absent, purged]  $ensure = present,
  String $mapfile                        = $title,
  Optional[String] $options              = undef,
  Optional[String] $order                = undef,
  String $maptype                        = 'file',
  Hash $mounts                           = {}
) {
  include autofs

  if !($maptype in $autofs::supported_map_types) {
    fail("maptype parameter must be one of ${autofs::supported_map_types}")
  }

  # $mapfile_prefix is equal to "${maptype}:", _unless_:
  # 1)  $maptype == 'file'
  # 2)  $use_map_prefix is false
  if $maptype != 'file' and $autofs::use_map_prefix {
    $mapfile_prefix = "${maptype}:"
  } else {
    $mapfile_prefix = ''
  }

  if $mapfile != $autofs::master_config and $directory != undef {
    if $ensure == present {
      concat::fragment { "${autofs::master_config}/${mapfile}":
        target  => $autofs::master_config,
        content => "${directory} ${mapfile_prefix}${mapfile} ${options}",
        order   => $order;
      }
    }
  }

  if $ensure == purged {
    $concat_ensure = absent
    # purge the directory after autofs has been restarted
    file { $directory:
      ensure  => absent,
      force   => true,
      require => Class['autofs::service'],
    }
  } else {
    $concat_ensure = $ensure
  }

  # Only create the mapfile and any mounts if $maptype == file
  if $maptype == file {
    concat { $mapfile:
      ensure         => $concat_ensure,
      owner          => $autofs::config_file_owner,
      group          => $autofs::config_file_group,
      path           => "${autofs::map_config_dir}/${mapfile}",
      mode           => '0644',
      warn           => true,
      ensure_newline => true,
      notify         => Class['autofs::service'],
      require        => Class['autofs::install'];
    }

    $mounts.each | $mount, $options | {
      autofs::mount {
        default:
          map => $mapfile;
        $mount:
          * => $options;
      }
    }
  }
}

