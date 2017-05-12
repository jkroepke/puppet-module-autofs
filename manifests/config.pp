#
class autofs::config inherits autofs {
  autofs::mapfile { $autofs::master_config:
    directory => undef,
  }

  create_resources('autofs::include', $autofs::includes)
  create_resources('autofs::mapfile', $autofs::mapfiles)
  create_resources('autofs::mount', $autofs::mounts)
}
