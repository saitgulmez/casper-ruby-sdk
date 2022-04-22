require_relative '../lib/types/cl_string.rb'
require_relative '../lib/types/cl_bool.rb'
require_relative '../lib/serialization/cl_value_bytes_parsers.rb'

describe CLString do  
  cl_string = CLString.new("ABC")
  describe "#get_value" do
    it "should return proper value" do  
      expect(cl_string.get_value).to eq("ABC")
    end
  end

  describe "#get_cl_type" do  
    it "should return proper cl_type" do 
      expect(cl_string.get_cl_type).to be_an_instance_of(String)
    end
  end

  describe "#get_cl_type" do  
    it "should return String type" do 
      expect(cl_string.get_cl_type).to eq('String')
    end
  end

  describe "#cl_string.get_size" do 
    it "should return proper string length" do 
      expect(cl_string.get_size).to eq(3)
    end
  end

  it "should return \'ABC\'" do  
    expect(cl_string.from_bytes("03000000414243")).to eql("ABC")
  end
end

describe CLBool do 
  my_bool = CLBool.new(false)
  cl_type = my_bool.get_cl_type
  describe "#get_cl_type" do 
    it "Bool should return proper cl_type" do 
      expect(cl_type).to eq('Bool')
    end
  end

  describe "#get_value" do
    it "should return proper value by calling get_value" do  
      my_bool1 = CLBool.new(false)
      my_bool2 = CLBool.new(true)
      expect(my_bool1.get_value).to eql(false)
      expect(my_bool2.get_value).to eql(true)
    end
  end

end