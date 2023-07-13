# frozen_string_literal: true

class ClassSpecHelper
  module CreateClasses
    # create a new class with the provided name, if the provided name is
    # namespaced, then assume each part of the namespace is a module and
    # create create modules as needed to satistfy the fully qualified name
    #
    # if base_class is provided, then the newly created class will extend it
    #
    # if block is provided, then the newly created class will execute
    # it via class_eval
    def create_class fully_qualified_class_name, base_class = nil, &block
      # because we're using eval, we validate the class name to ensure it is not mallicious
      unless /\A[A-Z][a-zA-Z0-9_]*(::[A-Z][a-zA-Z0-9_]*)*\z/.match?(fully_qualified_class_name)
        raise ClassNameError, "`#{fully_qualified_class_name}` is not a valid class name"
      end

      # ensure it was not already created here
      if Object.const_defined? fully_qualified_class_name
        raise ClassAlreadyExistsError, "Class `#{fully_qualified_class_name}` already exists within this application"
      end

      # ensure it does not already exist
      if @classes.key? fully_qualified_class_name.to_sym
        raise ClassAlreadyDynamicallyCreatedError, "Class `#{fully_qualified_class_name}` was already dynamically created with this helper"
      end

      # We prepend "::" to the class name to ensure the class is created at the top most scope
      class_name_parts = fully_qualified_class_name.to_s.split("::")
      class_name = class_name_parts.pop
      module_names = class_name_parts

      eval_code_lines = []

      # is this class nested within a namespace?
      is_namespaced = module_names.any?
      if is_namespaced
        # first module is always prepended by a "::" to ensure it is at the top most level
        eval_code_lines << "module ::#{module_names.shift}"
        # each remaining module name is just nested within this top most module
        module_names.each do |module_name|
          eval_code_lines << "module #{module_name}"
        end
      end
      # the class definition
      eval_code_lines << "class #{is_namespaced ? nil : "::"}#{class_name} #{base_class && "< #{base_class.name}"}"
      # add the expected number of "ends" to close the class and any nested modules
      end_count = eval_code_lines.count
      end_count.times do
        eval_code_lines << "end"
      end

      eval_code = eval_code_lines.join("\n")

      # we use `eval` because we want to create a class which immediately has
      # the expected name, unlike an anonymous class which is initially created
      # without the expected name and only receives the expected name once assigned
      # to a constant.
      eval eval_code # standard:disable Security/Eval

      # get the new class from the constant
      klass = Object.const_get fully_qualified_class_name

      # remember the full class name with namespace, so we can remove it again later
      @classes[fully_qualified_class_name.to_sym] = klass

      # finish building the class
      klass.class_eval(&block) if block
    end
  end
end
