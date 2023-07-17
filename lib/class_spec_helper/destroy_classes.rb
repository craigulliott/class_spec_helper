# frozen_string_literal: true

class ClassSpecHelper
  module DestroyClasses
    # remove any classes (constants) which were
    # created by the class helper
    def remove_all_dynamically_created_classes
      # destroy them in the reverse order which they were created
      @classes.keys.reverse_each do |fully_qualified_class_name|
        klass = @classes[fully_qualified_class_name]
        # destroy the class by removing the constant
        destroy_class klass
        # remove the class from the list of classes
        @classes.delete fully_qualified_class_name.to_sym
      end
    end

    # destroy the class by removing the constant
    def destroy_class klass
      fully_qualified_class_name = klass.name
      # get the namespace and class name from the fully qualified class name
      namespace = namespace_from_name fully_qualified_class_name
      class_name = class_name_from_name fully_qualified_class_name
      # remove the constant from the namespace
      namespace.send :remove_const, class_name
    end
  end
end
