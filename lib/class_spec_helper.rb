# frozen_string_literal: true

require "class_spec_helper/version"

require "class_spec_helper/create_classes"
require "class_spec_helper/destroy_classes"
require "class_spec_helper/naming"

class ClassSpecHelper
  class ClassAlreadyDynamicallyCreatedError < StandardError
  end

  class ClassAlreadyExistsError < StandardError
  end

  class ClassNameError < StandardError
  end

  def initialize
    @classes = {}
  end

  include CreateClasses
  include DestroyClasses
  include Naming
end
