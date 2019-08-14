# @summary
#   This class handles the configuration files.
#
# @api private
#
class autofs::config inherits autofs {
  file { "${autofs::map_config_dir}/autofs.conf":
    ensure  => file,
    content => epp('autofs/autofs.conf.epp'),
    owner   => $autofs::config_file_owner,
    mode    => '0644',
    notify  => Class['autofs::service'];
  }

  autofs::mapfile { $autofs::master_config:
    directory => undef;
  }

  $autofs::includes.each | $name, $options | {
    autofs::include { $name:
      * => $options;
    }
  }

  $autofs::mapfiles.each | $name, $options | {
    autofs::mapfile { $name:
      * => $options;
    }
  }

  $autofs::mounts.each | $name, $options | {
    autofs::mount { $name:
      * => $options;
    }
  }
}
