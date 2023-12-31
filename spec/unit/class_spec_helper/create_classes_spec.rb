RSpec.describe ClassSpecHelper do
  describe :CreateClasses do
    let(:class_spec_helper) { ClassSpecHelper.new }

    describe :create_class do
      it "creates a new class" do
        class_spec_helper.create_class :MyClass

        expect(MyClass).to be_a Class

        # expect it to be available at the top most Object level
        expect(Object.const_defined?(:MyClass)).to be true

        # remove it up again
        Object.send :remove_const, :MyClass
      end

      it "creates a new class which extends another class" do
        class_spec_helper.create_class :MyClass
        class_spec_helper.create_class :MyChildClass, MyClass

        expect(MyChildClass).to be_a Class
        expect(MyChildClass < MyClass).to be true

        # expect it to be available at the top most Object level
        expect(Object.const_defined?(:MyClass)).to be true

        # remove it up again
        Object.send :remove_const, :MyClass
        Object.send :remove_const, :MyChildClass
      end

      it "creates a new class and class_evals a provided block" do
        class_spec_helper.create_class :MyClass do
          def self.my_class_method
            true
          end
        end

        expect(MyClass.my_class_method).to be true

        # remove it up again
        Object.send :remove_const, :MyClass
      end

      it "creates a new namespaced class" do
        class_spec_helper.create_class "MyModule::MyClass"

        expect(MyModule::MyClass).to be_a Class

        # expect it to be available at the top most Object level
        expect(Object.const_defined?("MyModule::MyClass")).to be true

        # remove it up again
        MyModule.send :remove_const, :MyClass
        Object.send :remove_const, :MyModule
      end

      it "creates a new namespaced class which is namespaced within a class and not a module" do
        class_spec_helper.create_class "MainClass"
        class_spec_helper.create_class "MainClass::MyClass"

        expect(MainClass::MyClass).to be_a Class

        # expect it to be available at the top most Object level
        expect(Object.const_defined?("MainClass::MyClass")).to be true

        # remove it up again
        MainClass.send :remove_const, :MyClass
        Object.send :remove_const, :MainClass
      end

      it "creates a new deeply namespaced class which is namespaced within other classes and not modules" do
        class_spec_helper.create_class "MainClass"
        class_spec_helper.create_class "MainClass::NextClass"
        class_spec_helper.create_class "MainClass::NextClass::MyClass"

        expect(MainClass::NextClass::MyClass).to be_a Class

        # expect it to be available at the top most Object level
        expect(Object.const_defined?("MainClass::NextClass::MyClass")).to be true

        # remove it up again
        MainClass::NextClass.send :remove_const, :MyClass
        MainClass.send :remove_const, :NextClass
        Object.send :remove_const, :MainClass
      end

      it "raises an error if the class already exists" do
        expect {
          class_spec_helper.create_class :Integer
        }.to raise_error ClassSpecHelper::ClassAlreadyExistsError
      end
    end
  end
end
