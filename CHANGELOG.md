# Changelog

## [1.1.2](https://github.com/craigulliott/class_spec_helper/compare/v1.1.1...v1.1.2) (2023-07-17)


### Bug Fixes

* destroy classes in the reverse order which they were created to make sure nested classes are destroyed in a viable order ([61977da](https://github.com/craigulliott/class_spec_helper/commit/61977da3d0c0a1ff1c02e6a5faaceff0fad6fec1))

## [1.1.1](https://github.com/craigulliott/class_spec_helper/compare/v1.1.0...v1.1.1) (2023-07-17)


### Bug Fixes

* can now correctly build the new requested class if it is namespaced within already existing classes ([505b8c9](https://github.com/craigulliott/class_spec_helper/commit/505b8c9e07b3a326ac646c90ebb3b537df9d0981))

## [1.1.0](https://github.com/craigulliott/class_spec_helper/compare/v1.0.0...v1.1.0) (2023-07-17)


### Features

* manually running the garbage collector to allow for more reliable use of `ObjectSpace` ([87652cb](https://github.com/craigulliott/class_spec_helper/commit/87652cbd601348afbf21f4913483aa558f30d87e))

## 1.0.0 (2023-07-13)


### Features

* dynamically create named classes from within your test suite and have them destroyed automatically between each test ([8918b35](https://github.com/craigulliott/class_spec_helper/commit/8918b35e8a57527c9b95a3ca02d9c3d8526253f7))
