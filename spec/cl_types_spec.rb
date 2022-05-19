require_relative '../lib/types/cl_string.rb'
require_relative '../lib/types/cl_bool.rb'
require_relative '../lib/types/cl_i32.rb'
require_relative '../lib/types/cl_i64.rb'
require_relative '../lib/types/cl_u8.rb'
require_relative '../lib/types/cl_u32.rb'
require_relative '../lib/types/cl_u64.rb'
require_relative '../lib/types/cl_u128.rb'
require_relative '../lib/types/cl_u256.rb'
require_relative '../lib/types/cl_u512.rb'
require_relative '../lib/types/cl_unit.rb'
require_relative '../lib/types/cl_tuple.rb'
require_relative '../lib/types/constants.rb'
require_relative '../lib/serialization/cl_value_bytes_parsers.rb'
require 'json'

describe CLBool do 
  my_bool = CLBool.new(false)
  cl_type = my_bool.get_cl_type
  describe "#get_cl_type" do 
    it "Bool should return proper cl_type" do 
      expect(cl_type).to eql('Bool')
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

  it "toBytes() / fromBytes() do proper bytes serialization" do 
    bool1 = CLBool.new(false)
    bool2 = CLBool.new(true)

    bool1_bytes = CLValueBytesParsers::CLBoolBytesParser.to_bytes(bool1)
    expect(bool1_bytes).to eql([0])

    bool2_bytes = CLValueBytesParsers::CLBoolBytesParser.to_bytes(bool2)
    expect(bool2_bytes).to eql([1])

    from_bytes1 = CLValueBytesParsers::CLBoolBytesParser.from_bytes(bool1_bytes)

    expect(from_bytes1.get_value).to eql(bool1.get_value)
    expect(from_bytes1.get_cl_type).to eql(bool1.get_cl_type)
    
    from_bytes2 = CLValueBytesParsers::CLBoolBytesParser.from_bytes(bool2_bytes)

    expect(from_bytes2.get_value).to eql(bool2.get_value)
    expect(from_bytes2.get_cl_type).to eql(bool2.get_cl_type)
  end
end

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


describe CLi32 do
  # before :each do
  #   cli32 = CLi32.new
  # end
  it "should do proper to_bytes and from_bytes when value is -1" do 
    num1 = CLi32.new(-1)
    byte_array = CLValueBytesParsers::CLI32BytesParser.to_bytes(num1)
    expect(CLValueBytesParsers::CLI32BytesParser.from_bytes(byte_array)).to eql(num1.get_value)
  end

  it "should do proper to_bytes and from_bytes when value is 0" do 
    num2 = CLi32.new(0)
    byte_array = CLValueBytesParsers::CLI32BytesParser.to_bytes(num2)
    expect(CLValueBytesParsers::CLI32BytesParser.from_bytes(byte_array)).to eql(num2.get_value)
  end

  it "should do proper to_bytes and from_bytes when value is 1" do 
    num3 = CLi32.new(1)
    byte_array = CLValueBytesParsers::CLI32BytesParser.to_bytes(num3)
    expect(CLValueBytesParsers::CLI32BytesParser.from_bytes(byte_array)).to eql(num3.get_value)
  end

  it "should do proper to_bytes and from_bytes when value is MIN_I32" do  
    num4 = CLi32.new(MIN_I32)
    byte_array = CLValueBytesParsers::CLI32BytesParser.to_bytes(num4)
    expect(CLValueBytesParsers::CLI32BytesParser.from_bytes(byte_array)).to eql(num4.get_value)
  end


  it "should do proper to_bytes and from_bytes when value is MAX_I32" do 
    num5 = CLi32.new(MAX_I32)
    byte_array = CLValueBytesParsers::CLI32BytesParser.to_bytes(num5)
    expect(CLValueBytesParsers::CLI32BytesParser.from_bytes(byte_array)).to eql(num5.get_value)
  end
end


describe CLi64 do
  it "should do proper to_bytes and from_bytes when value is -10" do 
    first_cli64 = CLi64.new(-10)
    num1 = first_cli64.get_value
    byte_array1 = first_cli64.to_bytes(num1)
    expect(first_cli64.from_bytes(byte_array1)).to eql(num1)
  end

  it "should do proper to_bytes and from_bytes when value is 0" do 
    second_cli64 = CLi64.new(0)
    num2 = second_cli64.get_value
    byte_array2 = second_cli64.to_bytes(num2)
    expect(second_cli64.from_bytes(byte_array2)).to eql(num2)
  end

  it "should do proper to_bytes and from_bytes when value is 10" do 
    third_cli64 = CLi64.new(10)
    num3 = third_cli64.get_value
    byte_array3 = third_cli64.to_bytes(num3)
    expect(third_cli64.from_bytes(byte_array3)).to eql(num3)
  end

  it "should do proper to_bytes and from_bytes when value is MIN_I64" do  
    fourth_cli64 = CLi64.new(MIN_I64)
    min = fourth_cli64.get_value
    byte_array4 = fourth_cli64.to_bytes(min)
    expect(fourth_cli64.from_bytes(byte_array4)).to eq(min)
  end


  it "should do proper to_bytes and from_bytes when value is MAX_I64" do 
    fifth_cli64 = CLi64.new(MAX_I64)
    max = fifth_cli64.get_value
    byte_array5 = fifth_cli64.to_bytes(max)
    expect(fifth_cli64.from_bytes(byte_array5)).to eq(max)
  end
end

describe CLu8 do  
  it "should do proper to_bytes and from_bytes when value is MIN_U8" do 
    clu8 = CLu8.new(0)
    num1 = clu8.get_value
    byte_array1 = clu8.to_bytes(num1)
    expect(clu8.from_bytes(byte_array1)).to eql(num1)
  end

  it "should do proper to_bytes and from_bytes when value is MAX_U8" do 
    clu8 = CLu8.new(MAX_U8)
    num2 = clu8.get_value
    byte_array2 = clu8.to_bytes(num2)
    expect(clu8.from_bytes(byte_array2)).to eql(num2)
  end

  it "should raise error. Parameter value '-1' is not in range [0, 255]" do 
    clu8 = CLu8.new(-1)
    num3 = clu8.get_value
    err = clu8.to_bytes(num3)
    expect {raise StandardError, err}.
        to raise_error(err)
  end
end

describe CLu32 do  
  it "should do proper to_bytes and from_bytes when value is MIN_U32" do 
    clu32 = CLu32.new(0)
    num1 = clu32.get_value
    byte_array1 = clu32.to_bytes(num1)
    expect(clu32.from_bytes(byte_array1)).to eql(num1)
  end

  it "should do proper to_bytes and from_bytes when value is MAX_U32" do 
    clu32 = CLu32.new(MAX_U32)
    num2 = clu32.get_value
    byte_array2 = clu32.to_bytes(num2)
    expect(clu32.from_bytes(byte_array2)).to eql(num2)
  end

  it "should raise error. Parameter value  '-1' is out of range [0, MAX_U32]" do 
    clu32 = CLu32.new(-1)
    num3 = clu32.get_value
    err = clu32.to_bytes(num3)
    expect {raise StandardError, err}.
        to raise_error(err)
  end 

  it "should raise error. Parameter value '#{MAX_U32 + 1}' is out of range [0, MAX_U32]" do 
    clu32 = CLu32.new(MAX_U32 + 1)
    num3 = clu32.get_value
    err = clu32.to_bytes(num3)
    expect {raise StandardError, err}.
        to raise_error(err)
  end
end

describe CLu64 do  
  it "should do proper to_bytes and from_bytes when value is MIN_U64" do 
    clu64 = CLu64.new(0)
    num1 = clu64.get_value
    byte_array1 = clu64.to_bytes(num1)
    expect(clu64.from_bytes(byte_array1)).to eql(num1)
  end

  it "should do proper to_bytes and from_bytes when value is MAX_U64" do 
    clu64 = CLu64.new(MAX_U64)
    num2 = clu64.get_value
    byte_array2 = clu64.to_bytes(num2)
    expect(clu64.from_bytes(byte_array2)).to eql(num2)
  end

  it "should raise error. Parameter value  '-1' is out of range [0, MAX_U64]" do 
    clu64 = CLu64.new(-1)
    num3 = clu64.get_value
    err = clu64.to_bytes(num3)
    expect {raise StandardError, err}.
        to raise_error(err)
  end 

  it "should raise error. Parameter value '#{MAX_U64 + 1}' is out of range [0, MAX_U64]" do 
    clu64 = CLu64
    .new(MAX_U64 + 1)
    num3 = clu64.get_value
    err = clu64.to_bytes(num3)
    expect {raise StandardError, err}.
        to raise_error(err)
  end
end


describe CLu128 do  
  it "should do proper to_bytes and from_bytes when value is MIN_U128" do 
    clu128 = CLu128.new(0)
    num1 = clu128.get_value
    byte_array1 = clu128.to_bytes(num1)
    expect(clu128.from_bytes(byte_array1)).to eql(num1)
  end

  it "should do proper to_bytes and from_bytes when value is MAX_U128" do 
    clu128 = CLu128.new(MAX_U128)
    num2 = clu128.get_value
    byte_array2 = clu128.to_bytes(num2)
    expect(clu128.from_bytes(byte_array2)).to eql(num2)
  end

  it "should raise error. Parameter value  '-1' is out of range [0, MAX_U128]" do 
    clu128 = CLu128.new(-1)
    num3 = clu128.get_value
    err = clu128.to_bytes(num3)
    expect {raise StandardError, err}.to raise_error(err)
  end 

  it "should raise error. Parameter value '#{MAX_U128 + 1}' is out of range [0, MAX_U128]" do 
    clu128 = CLu128.new(MAX_U128 + 1)
    num3 = clu128.get_value
    err = clu128.to_bytes(num3)
    expect {raise StandardError, err}.to raise_error(err)
  end
end


describe CLu256 do  
  it "should do proper to_bytes and from_bytes when value is MIN_U256" do 
    clu256 = CLu256.new(0)
    num1 = clu256.get_value
    byte_array1 = clu256.to_bytes(num1)
    expect(clu256.from_bytes(byte_array1)).to eql(num1)
  end

  it "should do proper to_bytes and from_bytes when value is MAX_U256" do 
    clu256 = CLu256.new(MAX_U256)
    num2 = clu256.get_value
    byte_array2 = clu256.to_bytes(num2)
    expect(clu256.from_bytes(byte_array2)).to eql(num2)
  end

  it "should raise error. Parameter value  '-1' is out of range [0, MAX_U256]" do 
    clu256 = CLu256.new(-1)
    num3 = clu256.get_value
    err = clu256.to_bytes(num3)
    expect {raise StandardError, err}.to raise_error(err)
  end 

  it "should raise error. Parameter value '#{MAX_U256 + 1}' is out of range [0, MAX_U256]" do 
    clu256 = CLu256.new(MAX_U256 + 1)
    num3 = clu256.get_value
    err = clu256.to_bytes(num3)
    expect {raise StandardError, err}.to raise_error(err)
  end
end


describe CLu512 do  
  it "should do proper to_bytes and from_bytes when value is MIN_U512" do 
    clu512 = CLu512.new(0)
    num1 = clu512.get_value
    byte_array1 = clu512.to_bytes(num1)
    expect(clu512.from_bytes(byte_array1)).to eql(num1)
  end

  it "should do proper to_bytes and from_bytes when value is MAX_U512" do 
    clu512 = CLu512.new(MAX_U512)
    num2 = clu512.get_value
    byte_array2 = clu512.to_bytes(num2)
    expect(clu512.from_bytes(byte_array2)).to eql(num2)
  end

  it "should raise error. Parameter value  '-1' is out of range [0, MAX_U512]" do 
    clu512 = CLu512.new(-1)
    num3 = clu512.get_value
    err = clu512.to_bytes(num3)
    expect {raise StandardError, err}.to raise_error(err)
  end 

  it "should raise error. Parameter value '#{MAX_U512 + 1}' is out of range [0, MAX_U512]" do 
    clu512 = CLu512.new(MAX_U512 + 1)
    num3 = clu512.get_value
    err = clu512.to_bytes(num3)
    expect {raise StandardError, err}.to raise_error(err)
  end
end

describe CLUnit do  
  it "should return proper type" do 
    cl = CLUnit.new()
    expect(cl.get_cl_type).to eql("Unit")
  end

  it "should return proper value" do  
    cl = CLUnit.new()
    expect(cl.get_value).to eql(nil)
  end

  it "to_json / from_json" do  
    cl = CLUnit.new()
    json = cl.to_json
    expected_json = '{"bytes":"","cl_type":"Unit"}'
    expect(json).to eql(expected_json)
    expect(cl.from_json(json)).to eql(cl.get_hash)
  end
end

describe CLTuple do 
  describe CLTuple1 do  
    it "should return proper CLType" do 
      bool = CLBool.new(true)
      t1 = CLTuple1.new([bool])
      expect(t1.get_cl_type).to eql("Tuple1 (Bool)")

      str = CLString.new("ABC")
      t2 = CLTuple1.new([str])
      expect(t2.get_cl_type).to eql("Tuple1 (String)")

      i32 = CLi32.new(99)
      t3 = CLTuple1.new([i32])
      expect(t3.get_cl_type).to eql("Tuple1 (I32)")
    end

    it "should throw an error when tuple elements are not in a correct format" do 
      # tuple = CLTuple1.new([CLBool.new(true), CLBool.new(false)])
      tuple = CLTuple1.new(['a'])
      err = tuple.get_cl_type
      expect {raise err }.to raise_error(StandardError, "Invalid data type(s) provided.")
    end
    it "should return error when tuple is not correctly built" do 
      bool = CLBool.new(false)
      tuple1 = CLTuple1.new([bool, bool])
      err = tuple1.get_cl_type
      expect {raise err}.to raise_error(StandardError, "Too many elements!")
    end

    it "should do proper to_bytes and from_bytes for Tuple1" do
      bool1 = CLBool.new(false)
      tuple = CLTuple1.new([bool1])

      bool_bytes = CLValueBytesParsers::CLTupleBytesParser.to_bytes(tuple)
      bool2 = CLValueBytesParsers::CLTupleBytesParser.from_bytes([bool1.get_cl_type], bool_bytes)
      
      expect(bool2.get_value).to eql(bool1.get_value)
     
      i32 = CLi32.new(10)
      tuple = CLTuple1.new([i32])
      
      i32_bytes = CLValueBytesParsers::CLTupleBytesParser.to_bytes(tuple)
      i32_value = CLValueBytesParsers::CLTupleBytesParser.from_bytes([i32.get_cl_type], i32_bytes)
      expect(i32_value).to eql(i32.get_value)
    end
  end

  describe CLTuple2 do  
    it "should return proper CLType" do 
      bool = CLBool.new(true)
      str = CLString.new("ABC")
      t1 = CLTuple2.new([bool, str])
      expect(t1.get_cl_type).to eql("Tuple2 (Bool, String)")


      str2 = CLString.new("XYZ")
      u512 = CLu512.new(MAX_U512)
      t2 = CLTuple2.new([str,u512])
      expect(t2.get_cl_type).to eql("Tuple2 (String, U512)")
    end

    it "should throw an error when tuple elements are not in a correct format" do 
      tuple = CLTuple2.new(['a', 10])
      err = tuple.get_cl_type
      expect {raise err }.to raise_error(StandardError, "Invalid data type(s) provided.")
    end

    it "should return error when tuple is not correctly built" do 
      bool = CLBool.new(false)
      tuple2 = CLTuple2.new([bool, bool, bool])
      err = tuple2.get_cl_type
      expect {raise err}.to raise_error(StandardError, "Too many elements!")
    end
    
    it "should do proper to_bytes and from_bytes for Tuple2" do
      bool1 = CLBool.new(true)
      bool2 = CLBool.new(false)
      tuple = CLTuple2.new([bool1, bool2])
      tuple_bytes = CLValueBytesParsers::CLTupleBytesParser.to_bytes(tuple)
    end
  end

  describe CLTuple3 do  
    it "should return proper CLType" do 
      bool = CLBool.new(true)
      str = CLString.new("ABC")
      u512 = CLu512.new(MAX_U512)
      t1 = CLTuple3.new([bool, str, u512])
      expect(t1.get_cl_type).to eql("Tuple3 (Bool, String, U512)")
    end

    it "should throw an error when tuple elements are not in a correct format" do 
      tuple = CLTuple3.new(['a', 10, true])
      err = tuple.get_cl_type
      expect {raise err }.to raise_error(StandardError, "Invalid data type(s) provided.")
    end

    it "should return error when tuple is not correctly built" do 
      bool = CLBool.new(false)
      tuple3 = CLTuple3.new([bool, bool, bool, bool])
      err = tuple3.get_cl_type
      expect {raise err}.to raise_error(StandardError, "Too many elements!")
    end
  end
end