RSpec.describe ClassSpecHelper do
  describe :Naming do
    let(:class_spec_helper) { ClassSpecHelper.new }

    describe :namespace_from_name do
      it "returns Object for a class name which is not namespaced" do
        expect(class_spec_helper.namespace_from_name("MyClass")).to eq Object
      end

      it "returns the namespace for a class name which is namespaced" do
        # note, this class does not actually exist, but that's OK for this test
        expect(class_spec_helper.namespace_from_name("Integer::MyClass")).to eq Integer
      end
    end

    describe :class_name_from_name do
      it "returns the class name for a name which is not namespaced" do
        expect(class_spec_helper.class_name_from_name("MyClass")).to eq "MyClass"
      end

      it "returns the class name for a name which is namespaced" do
        expect(class_spec_helper.class_name_from_name("Integer::MyClass")).to eq "MyClass"
      end
    end
  end
end
