# frozen_string_literal: true

RSpec.describe ClassSpecHelper do
  it "has a version number" do
    expect(ClassSpecHelper::VERSION).to_not be nil
  end

  describe :initialize do
    it "initializes without raising an error" do
      expect {
        ClassSpecHelper.new
      }.to_not raise_error
    end
  end
end
