2019-08-17 Release 5.0.0

* Support Debian 10 and bump max version dependencies ([#19](https://github.com/jkroepke/puppet-module-autofs/pull/19); jkroepke)
* Add puppet-lint-absolute_classname-check ([#20](https://github.com/jkroepke/puppet-module-autofs/pull/20); jkroepke)
* Added configuration for autofs.conf ([#21](https://github.com/jkroepke/puppet-module-autofs/pull/21); jkroepke)

2019-05-01 Release 4.1.0

* Bump dependencies ([#17](https://github.com/jkroepke/puppet-module-autofs/pull/17); jkroepke)
* Add spec unit tests for autofs class ([#18](https://github.com/jkroepke/puppet-module-autofs/pull/18); jkroepke)

2019-03-17 Release 4.0.1

* Fix forge deployment

2019-03-17 Release 4.0.0

* Added Puppet 6
* Added Debian 9
* Upgrade PDK & modernize module ([#15](https://github.com/jkroepke/puppet-module-autofs/pull/15); jkroepke)

2018-06-15 Release 3.0.0

* Added acceptance tests for various supported platforms. ([#13](https://github.com/jkroepke/puppet-module-autofs/pull/12); rehanone)
* Converted `params.pp` to hiera5 module data pattern. ([#12](https://github.com/jkroepke/puppet-module-autofs/pull/12); rehanone)
* Added Puppet 4 types for all parameters. ([#11](https://github.com/jkroepke/puppet-module-autofs/pull/11); rehanone)
* Converted the module to use Puppet Development Kit. ([#10](https://github.com/jkroepke/puppet-module-autofs/pull/10); rehanone)
* Fix syntax issues in documentation

2017-03-04 Release 2.0.4

* Set default mount options to `-rw` to prevent autofs syntax errors.
* Reduce the size of the forge archive

2016-10-21 Release 2.0.3

* Added more spec files ([#5](https://github.com/jkroepke/puppet-module-autofs/pull/5))
* Add parameter maptype ([#4](https://github.com/jkroepke/puppet-module-autofs/pull/4); jearls)
* Add ensure parameter to ::autofs::mapfile ([#2](https://github.com/jkroepke/puppet-module-autofs/pull/2); jearls)
* Added spec tests from voxpupuli

2016-04-12 Release 2.0.2

* Added Gentoo support ([#1](https://github.com/jkroepke/puppet-module-autofs/pull/1); daugustin)
* Fixed documentation issues

2016-02-15 Release 2.0.1

* Fixed documentation issues

2016-02-15 Release 2.0.0

* Refactor Module
* Added support for concat 2
* Added parameter for package and service parameters
* Fixed "Duplicate declaration"-Errors
* Added ArchLinux Support


2015-06-16 Release 1.1.0 (Reid Vandewiele)

* Enable TravisCI and add Gemfile
* Add metadata.json
* fixed puppet-lint errors
* added concat resource
* added concat resource
* Remove deprecated concat::setup class
* fix lint warning
* just install autofs-ldap, dependencies will take care of the rest
* Put options at the end only in master file. Else between key and location
* Fix ordering issue with preamble fragment
* Adding a puppet comment in the managed files

2013-09-28 Release 1.0.0 (Reid Vandewiele)

Summary:

Improved validation and permit ensuring the absense of mounts

Backwards-incompatible changes:

 - Update dependency on concat to use puppetlabs-concat

Features:

 - Improved input validation
 - Add autofs direct mount
 - Add ensure parameter to autofs::mount
