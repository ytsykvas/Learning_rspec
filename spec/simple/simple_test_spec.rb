require 'rails_helper'

RSpec.describe "simple test" do
  describe "math" do
    it "multuply" do
      expect(8*2).to eq(16)
    end
    it "plus" do
      expect(2+4).to eq(6)
    end
    
  end

  describe "String" do
    let(:obj) {String.new}
    it "empty?" do
      expect(obj).to eq("") 
    end
  end
end
