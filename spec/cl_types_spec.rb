require_relative '../lib/types/cl_string.rb'
require_relative '../lib/types/cl_bool.rb'
require_relative '../lib/types/cl_i32.rb'
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

describe CLi32 do
  # before :each do
  #   cli32 = CLi32.new
  # end
  it "should do proper to_bytes and from_bytes when value is -1" do 
    first_cli32 = CLi32.new(-1)
    num1 = first_cli32.get_value
    byte_array1 = first_cli32.to_bytes(num1)
    expect(first_cli32.from_bytes(byte_array1)).to eql(num1)
  end

  it "should do proper to_bytes and from_bytes when value is 0" do 
    second_cli32 = CLi32.new(0)
    num2 = second_cli32.get_value
    byte_array2 = second_cli32.to_bytes(num2)
    expect(second_cli32.from_bytes(byte_array2)).to eql(num2)
  end

  it "should do proper to_bytes and from_bytes when value is 1" do 
    third_cli32 = CLi32.new(1)
    num3 = third_cli32.get_value
    byte_array3 = third_cli32.to_bytes(num3)
    expect(third_cli32.from_bytes(byte_array3)).to eql(num3)
  end

  it "should do proper to_bytes and from_bytes when value is -2147483648" do  
    fourth_cli32 = CLi32.new(-2147483648)
    min = fourth_cli32.get_value
    byte_array4 = fourth_cli32.to_bytes(min)
    expect(fourth_cli32.from_bytes(byte_array4)).to eq(min)
  end


  it "should do proper to_bytes and from_bytes when value is 2147483647" do 
    fifth_cli32 = CLi32.new(2147483647)
    max = fifth_cli32.get_value
    byte_array5 = fifth_cli32.to_bytes(max)
    expect(fifth_cli32.from_bytes(byte_array5)).to eq(max)
  end
end