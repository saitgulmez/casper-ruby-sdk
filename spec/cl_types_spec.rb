require_relative '../lib/types/cl_string.rb'

describe CLString do  
  cl_string = CLString.new("ABC")
  describe "#get_value" do
    it "passes, it should return proper value" do  
      expect(cl_string.get_value).to eq("ABC")
    end
  end

  describe "#get_cl_type" do  
    it "passes, it should return proper type" do 
      expect(cl_string.get_cl_type).to be_an_instance_of(String)
    end
  end

  describe "#get_cl_type" do  
    it "passes, it should return String type" do 
      expect(cl_string.get_cl_type).to eq('String')
    end
  end

  describe "#get_size" do 
    it "passes, it should return proper string length" do 
      expect(cl_string.get_size).to eq(3)
    end
  end

end