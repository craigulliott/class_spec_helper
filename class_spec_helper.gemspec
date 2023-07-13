# frozen_string_literal: true

require_relative "lib/class_spec_helper/version"

Gem::Specification.new do |spec|
  spec.name = "class_spec_helper"
  spec.version = ClassSpecHelper::VERSION
  spec.authors = ["Craig Ulliott"]
  spec.email = ["craigulliott@gmail.com"]

  spec.summary = "Easily create and destroy named classes for use within your specs."
  spec.description = "Ruby gem to create named classes for use within your specs, and then clear them out automatically between specs."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["source_code_uri"] = "https://github.com/craigulliott/class_spec_helper/"
  spec.metadata["changelog_uri"] = "https://github.com/craigulliott/class_spec_helper/blob/main/CHANGELOG.md"

  spec.files = ["README.md", "LICENSE.txt", "CHANGELOG.md", "CODE_OF_CONDUCT.md"] + Dir["lib/**/*"]

  spec.require_paths = ["lib"]
end
