# ClassSpecHelper


[![Gem Version](https://badge.fury.io/rb/class_spec_helper.svg)](https://badge.fury.io/rb/class_spec_helper)
[![Specs](https://github.com/craigulliott/class_spec_helper/actions/workflows/specs.yml/badge.svg)](https://github.com/craigulliott/class_spec_helper/actions/workflows/specs.yml)
[![Types](https://github.com/craigulliott/class_spec_helper/actions/workflows/types.yml/badge.svg)](https://github.com/craigulliott/class_spec_helper/actions/workflows/types.yml)
[![Coding Style](https://github.com/craigulliott/class_spec_helper/actions/workflows/linter.yml/badge.svg)](https://github.com/craigulliott/class_spec_helper/actions/workflows/linter.yml)


### What this gem is

A helper class for creating up and easily deleting (cleaning up) classes within a testing environment.

If you are building something which uses metaprogramming to dynamically create classes, then this gem will be a useful tool within your test suite.

## Key Features

* Easily create named classes within your test suite
* Optionally provide base a base class for your new class to extend from
* Optionally provide a block which will be called within your new class via class_eval
* Handles class namespacing automatically
* Have those classes destroyed automatically between tests

## Installation

Add the gem to your Gemfile:

```ruby
gem "class_spec_helper"
```

Or to your `*.gemspec`

```ruby
spec.add_development_dependency "class_spec_helper"
```

And run bundle install

    $ bundle install


## Getting Started

#### Setting up rspec

Install ClassSpecHelper into your `spec/spec_helper.rb`

```ruby
require "class_spec_helper"

RSpec.configure do |config|

  # make class_spec_helper conveniently accessable within your test suite
  config.add_setting :class_spec_helper
  config.class_spec_helper = ClassSpecHelper.new

  # destroy these dyanmically created classes after each test
  config.after(:each) do
    config.class_spec_helper.remove_all_dynamically_created_classes
  end
end

```


#### An example test which creates classes dynamically

Note, that these dynamically created classes will be destroyed automatically after each test has been run

```ruby
RSpec.describe ClassSpecHelper do
  let(:class_spec_helper) { RSpec.configuration.class_spec_helper }

  describe "for a class and a child class" do
    before(:each) do
      # create the class named MyClass
      class_spec_helper.create_class :MyClass
      # note than MyClass will be available here
      class_spec_helper.create_class :MyChildClass, MyClass
    end

    it "created a class which correctly extends the base class" do
      expect(MyClass < MyChildClass).to be true
    end

  end
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

We use [Conventional Commit Messages](https://gist.github.com/qoomon/5dfcdf8eec66a051ecd85625518cfd13).

Code should be linted and formatted according to [Ruby Standard](https://github.com/standardrb/standard).

Publishing is automated via github actions and Googles [Release Please](https://github.com/google-github-actions/release-please-action) github action

We prefer using squash-merges when merging pull requests because it helps keep a linear git history and allows more fine grained control of commit messages which get sent to release-please and ultimately show up in the changelog.

Type checking is enabled for this project. You can find the corresponding `rbs` files in the sig folder.

Install types for the packages used in development (such as `rspec`) by running

    $ rbs collection install

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/craigulliott/class_spec_helper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/craigulliott/class_spec_helper/blob/master/CODE_OF_CONDUCT.md).

## License

This software is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ClassSpecHelper project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/craigulliott/class_spec_helper/blob/master/CODE_OF_CONDUCT.md).
