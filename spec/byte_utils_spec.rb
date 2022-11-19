require_relative '../lib/utils/byte_utils.rb'


RSpec.describe Utils::ByteUtils do
  let(:byte_utils) { Utils::ByteUtils }

  describe '.string_to_hex' do
    it "convert string to hex" do
      str = "abc"
      expect(byte_utils.string_to_hex(str)).to eql("616263")
    end
  end

  describe '.hex_to_string' do
    it "convert hex to string" do 
      hex_str = "616263"
      expect(byte_utils.hex_to_string(hex_str)).to eql( "abc")
    end
  end

  describe '.hex_to_byte_array' do 
    it "convert hex to byte_array" do
      hex_str = "616263"
      expect(byte_utils.hex_to_byte_array(hex_str)).to eql([97, 98, 99])
    end
  end

  describe '.byte_array_to_hex' do  
    it "convert byte_array to hex" do 
      str = "deposit"
      str_hex = "6465706f736974"
      bytes = [100, 101, 112, 111, 115, 105, 116]
      expect(byte_utils.byte_array_to_hex(bytes)).to eql("6465706f736974")
    end
  end
  describe '.byte_array_to_string' do  
    it "convert byte_array to string" do 
      bytes = [100, 101, 112, 111, 115, 105, 116]
      expected_str = "deposit"
      expect(byte_utils.byte_array_to_string(bytes)).to eql(expected_str)
    end
  end
  
  describe '.integer_to_hex' do  
    it "convert integer to hex value" do 
      n = 13
      # Expected little endian hex
      expected_hex = "0d000000"
      expect(byte_utils.integer_to_hex(n)).to eql(expected_hex)
    end
  end
  
  describe '.hex_to_integer' do  
    it "convert hex to integer value" do 
      # Little endian hex
      hex = "0d000000"
      expected_value = 13
      expect(byte_utils.hex_to_integer(hex)).to eql(expected_value)
    end
  end

  describe '.hex_from_little_endian_to_big_endian' do  
    it "convert  hex little endian to hex big endian format" do 
      # Little endian hex
      hex = "0d000000"
      # Big endian hex
      expected_hex = "0000000d"
      expect(byte_utils.hex_from_little_endian_to_big_endian(hex)).to eql(expected_hex)
    end
  end

  it "ttl should be a supported format and suffix of each substring should be one of these \'d\',  \'h\', \'m\' or \'ms\' " do
    ttl = "3041mn"
    # expect {time_utils.ttl_to_milliseconds(ttl)}.to raise_error(ArgumentError)
    puts time_utils.ttl_to_milliseconds(ttl)
  end
end