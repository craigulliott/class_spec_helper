RSpec.describe ClassSpecHelper do
  describe :DestroyClasses do
    let(:class_spec_helper) { ClassSpecHelper.new }

    describe :remove_all_dynamically_created_classes do
      it "does not raise an error when no classes have been created" do
        expect {
          class_spec_helper.remove_all_dynamically_created_classes
        }.to_not raise_error
      end

      describe "after a class has been added" do
        before(:each) do
          class_spec_helper.create_class :MyClass
        end

        it "removes the class" do
          # expect it to be available at the top most Object level
          expect(MyClass).to be_a Class

          class_spec_helper.remove_all_dynamically_created_classes

          expect {
            MyClass
          }.to raise_error NameError
        end

        describe "after other classes are nested within this class" do
          before(:each) do
            class_spec_helper.create_class "MyClass::FooClass"
            class_spec_helper.create_class "MyClass::FooClass::BarClass"
            class_spec_helper.create_class "MyClass::FooClass::BarClass::FinalClass"
          end

          it "removes the classes" do
            # expect it to be available at the top most Object level
            expect(MyClass).to be_a Class
            expect(MyClass::FooClass).to be_a Class
            expect(MyClass::FooClass::BarClass).to be_a Class
            expect(MyClass::FooClass::BarClass::FinalClass).to be_a Class

            class_spec_helper.remove_all_dynamically_created_classes

            expect {
              MyClass::FooClass::BarClass::FinalClass
            }.to raise_error NameError
            expect {
              MyClass::FooClass::BarClass
            }.to raise_error NameError
            expect {
              MyClass::FooClass
            }.to raise_error NameError
            expect {
              MyClass
            }.to raise_error NameError
          end
        end
      end
    end

    describe :destroy_class do
      before(:each) do
        class_spec_helper.create_class :MyClass
      end

      it "removes a class which was created by the class helper" do
        class_spec_helper.destroy_class MyClass

        expect {
          MyClass
        }.to raise_error NameError
      end

      it "removes a class which was created outside the class helper" do
        class MyClass; end # standard:disable Lint/ConstantDefinitionInBlock

        class_spec_helper.destroy_class MyClass

        expect {
          MyClass
        }.to raise_error NameError
      end
    end
  end
end
