#
class autofs::config inherits autofs {
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
