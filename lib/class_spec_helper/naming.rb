# frozen_string_literal: true

class ClassSpecHelper
  module Naming
    # provided with a fully qualified class name, return the namespace
    #
    # For example:
    #   namespace_from_name "Foo::Bar::Baz" will return the constant Foo
    #   namespace_from_name "Foo" will return the constant Object
    def namespace_from_name fully_qualified_class_name
      namespace_parts = fully_qualified_class_name.split("::")[0..-2]
      namespace_name = namespace_parts.join("::")

      # if the model was namespaced, then return the coresponding constant
      # if there is no namespace, then use `Object` which is the top most
      # namespace in ruby
      if namespace_name == ""
        Object
      else
        Object.const_get namespace_name
      end
    end

    # provided with a fully qualified class name, return the class name
    #
    # For example:
    #   namespace_from_name "Foo::Bar::Baz" will return the string "Baz"
    #   namespace_from_name "Foo" will return the string "Foo"
    def class_name_from_name name
      name.split("::").last
    end
  end
end
