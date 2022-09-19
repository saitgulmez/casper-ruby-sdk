require_relative '../types/constants.rb'
require_relative '../types/error.rb'
require 'active_support/core_ext/hash/keys'

class FalseClass; def to_i; 0 end end
class TrueClass; def to_i; 1 end end

module CLValueBytesParsers

  module CLBoolBytesParser
    extend self
    def to_bytes(clbool)
      value = clbool.get_value
      if value == true || value == false
        [value.to_i].pack("C").unpack("C")
      else
        "CLValue TypeError"
      end
    end

    def from_bytes(bytes)
      if bytes.first == 1
        CLBool.new(true) 
      else
        CLBool.new(false) 
      end
    end
  end

  module CLStringBytesParser
    extend self
    # @param [String] raw_bytes
    def from_bytes(raw_bytes)
      first_4_bytes = raw_bytes[0..7]
      string_length = [first_4_bytes].pack("H*").unpack("l").first
      rest = raw_bytes[8..raw_bytes.length]
      len2 = (rest.length) / 2
      if string_length == len2
        hex_to_string_value = [raw_bytes[8..raw_bytes.length]].pack("H*")
      else
        raise "Error"
      end
    end

    # @param [String] value 
    def to_bytes(value)
      len = value.length
      hex1 = len.to_s(16).rjust(8, '0').scan(/../).reverse.join('')
      hex2 = value.unpack("H*").first
      hex1 + hex2
    end

    def to_json 
    end

    def from_json
    end
  end


  module CLI32BytesParser
    extend self
    @@check = 0
    def from_bytes(byte_array)
      if @@check < 0
        @@check = 0
        bytes = byte_array.map { |b| b.chr }.join
        bytes.unpack("B*").first.scan(/[01]{8}/)
        bytes.unpack("l*").first
      else
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
      end
    end

    def to_bytes(clvalue)
      value = clvalue.get_value
      if value < 0  && value >= MIN_I32
        @@check = value
        [value].pack("l<*").unpack("C*")
      elsif value >= 0 && value <= MAX_I32
        [value].pack("l<*").unpack("C*")
      else
        "Parameter value '#{value}' is out of range."
      end
    end
  end 

  module CLI64BytesParser
    extend self
    @@check = 0
    def from_bytes(byte_array)
      if @@check < 0
        @@check = 0
        bytes = byte_array.map { |b| b.chr }.join
        bytes.unpack("B*").first.scan(/[01]{8}/)
        bytes.reverse.unpack("q*").first
      else
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
      end
    end

    def to_bytes(value)
      if value < 0 && value >= MIN_I64
        @@check = value
        [value].pack("q>*").unpack("C*")
      elsif value >= 0 && value <= MAX_I64
        [value].pack("q<*").unpack("C*")
      else
        "Parameter value '#{value}' is out of range."
      end
    end
  end

  module CLU8BytesParser
    extend self
    def from_bytes(byte_array)
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
    end

    def to_bytes(value)
      if value < 0 || value > MAX_U8
        @@check = value
        "Parameter value '#{value}' is out of range."
      else
        [value].pack("C").unpack("C")
      end
    end
  end
  
  module CLU32BytesParser
    extend self
    def from_bytes(byte_array)
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
    end

    def to_bytes(value)
      if value < 0 || value > MAX_U32
        "Parameter value '#{value}' is out of range."
      else
        [value].pack("L<*").unpack("C*")
      end
    end
  end

  module CLU64BytesParser
    extend self
    def from_bytes(byte_array)
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
    end

    def to_bytes(value)
      if value < 0 || value > MAX_U64
        "Parameter value '#{value}' is out of range."
      else
        [value].pack("Q<*").unpack("C*")
      end
    end
  end

  module CLU128BytesParser
    extend self
    def from_bytes(byte_array)
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
    end

    def to_bytes(value)
      if value < 0 || value > MAX_U128
        "Parameter value '#{value}' is out of range."
      else
        str = value.to_s(16)
        arr = str.scan(/[0-9a-f]{4}/).map { |x| x.to_i(16) }
        packed = arr.pack("n*").unpack("C*").reverse()
      end
    end
  end

  module CLU256BytesParser
    extend self
    def from_bytes(byte_array)
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
    end

    def to_bytes(value)
      if value < 0 || value > MAX_U256
        "Parameter value '#{value}' is out of range."
      else
        str = value.to_s(16)
        arr = str.scan(/[0-9a-f]{4}/).map { |x| x.to_i(16) }
        packed = arr.pack("n*").unpack("C*").reverse()
      end
    end
  end
  
  module CLU512BytesParser
    extend self
    def from_bytes(byte_array)
        byte_array.reverse.inject(0) {|m, b| (m << 8) + b }
    end

    def to_bytes(value)
      if value < 0 || value > MAX_U512
        "Parameter value '#{value}' is out of range."
      else
        str = value.to_s(16)
        arr = str.scan(/[0-9a-f]{4}/).map { |x| x.to_i(16) }
        packed = arr.pack("n*").unpack("C*").reverse()
      end
    end
  end

  module CLUnitBytesParser
    extend self
    def from_bytes(byte_array)
      if byte_array.empty?
        [].pack("")
      else
        "byte_array should be empty!"
      end
    end
    
    def to_bytes
      "".bytes
    end
  end

  module CLTupleBytesParser
    extend self
    def to_bytes(tuple)
      # tuple_name can be Tuple1 or Tuple2 or Tuple3
      tuple_name = tuple.get_tuple_name
      size = tuple.get_size
      data = tuple.get_value
      if size == 1
        type = data[0].get_cl_type
        value = data[0]
        convert_to_bytes(type, value)
      elsif size == 2
        # puts data[0]
        # puts data[1]
        clvalue1 = data[0]
        type_of_clvalue1 = clvalue1.get_cl_type
        clvalue2 = data[1]
        type_of_clvalue2 = clvalue2.get_cl_type
        convert_to_bytes(type_of_clvalue1, clvalue1) + convert_to_bytes(type_of_clvalue2, clvalue2)
      # elsif size == 3
      else
        raise "error"
      end
    end

    def from_bytes(types, byte_array)
      size = types.size
      if size == 1
        type = types[0]
        convert_from_bytes(type, byte_array)
      elsif size == 2
        type_of_clvalue1 = types[0]
        type_of_clvalue2 = types[1]
      else
        raise "error"
      end
    end 
  end
 
  module CLKeyBytesParser
    extend self

    def to_bytes(cl_list)

    end

    def from_bytes(byte_array)

    end
  end

  module CLURefBytesParser
    extend self

    # @param [String] str
    # @return [Array<Integer>] decoded
    def decode_base_16(str)
      decoded = [str].pack('H*').unpack("C*")
    end

    # @param [Array<Integer>] byte_array
    # @return [String] encoded
    def encode_base_16(byte_array)
      encoded = byte_array.pack("C*").unpack("H*").first
    end
    
    # @param [CLURef] clvalue
    # @return [Array<Integer>] value
    def to_bytes(clvalue)
      value = clvalue.get_value
      access_rights = clvalue.get_access_rights
      value = value.dup
      value.push(access_rights)
    end

    # @param [Array<Integer>] byte_array
    # @return [CLURef] uref
    def from_bytes(byte_array)
      get_access_rights = byte_array.last
      byte_array = byte_array[0..byte_array.size-2]
      # p byte_array
      uref = CLURef.new(byte_array, get_access_rights)
    end
  end

  module CLOptionBytesParser
    extend self

    # @param [CLOption] cl_option
    def to_bytes(cl_option)
      
    end
  end

  module CLListBytesParser
    extend self

    def to_bytes(cl_list)

    end

    def from_bytes(byte_array)

    end
  end
  
  module CLByteArrayBytesParser
    extend self

    def to_bytes(cl_byte_array)

    end

    def from_bytes(byte_array)
      
    end
  end
  
  module CLResultBytesParser
    extend self

    def to_bytes(cl_result)

    end

    def from_bytes(byte_array)
      
    end
  end
  
  module CLMapBytesParser
    extend self

    def to_bytes(cl_map)

    end

    def from_bytes(byte_array)
      
    end
  end
  
  module CLAnyBytesParser
    extend self

      def to_bytes(cl_any)

      end

      def from_bytes(byte_array)

      end
  end

  module CLPublicKeyBytesParser
    extend self
      # @param [String] str
      # @return [Array<Integer>] decoded
      def decode_base_16(str)
        decoded = [str].pack('H*').unpack("C*")
      end

      # @param [Array<Integer>] byte_array
      # @return [String] encoded
      def encode_base_16(byte_array)
        encoded = byte_array.pack("C*").unpack("H*").first
      end

      def to_bytes(cl_public_key)
        tag = cl_public_key.get_cl_public_key_tag
        raw_public_key = cl_public_key.get_value
        [tag] + raw_public_key
      end

      def from_bytes(byte_array)
        byte_array
        # tag = byte_array[0]
        tag = 0
        if byte_array[0] == 1 && byte_array.size == 33
          tag = 1
        elsif byte_array[0] == 2 && byte_array.size == 34
          tag = 2
        else
          raise ArgumentError.new("Invalid parameter")
        end
        CLPublicKey.new(byte_array[1..], tag)
      end
  end
end


def convert_to_bytes(type, value)
  case type 
  when "Bool"
    CLValueBytesParsers::CLBoolBytesParser.to_bytes(value)
  when "I32"
    CLValueBytesParsers::CLI32BytesParser.to_bytes(value)
  when "I64"
    CLValueBytesParsers::CLI64BytesParser.to_bytes(value)
  when "U8"
    CLValueBytesParsers::CLU8BytesParser.to_bytes(value)
  when "U32"
    CLValueBytesParsers::CLU32BytesParser.to_bytes(value)
  when "U64"
    CLValueBytesParsers::CLU64BytesParser.to_bytes(value)
  when "U128"
    CLValueBytesParsers::CLU128BytesParser.to_bytes(value)
  when "U256"
    CLValueBytesParsers::CLU256BytesParser.to_bytes(value)
  when "U512"
    CLValueBytesParsers::CLU512BytesParser.to_bytes(value)
  when "Unit"
    CLValueBytesParsers::CLUnitBytesParser.to_bytes(value)
  when "String"
    CLValueBytesParsers::CLStringBytesParser.to_bytes(value)
  # when "Key"
  # when "URef"
  # when "Option"
  # when "List"
  # when "ByteArray"
  # when "Result"
  # when "Map"
  # when "Tuple1"
  # when "Tuple2"
  # when "Tuple3"
  # when "Any"
  # when "PublicKey"
  else
    "Unknown"
  end
end

def convert_from_bytes(type, byte_array)
  # p type
  case type 
  when "Bool"
    CLValueBytesParsers::CLBoolBytesParser.from_bytes(byte_array)
  when "I32"
    CLValueBytesParsers::CLI32BytesParser.from_bytes(byte_array)
  when "I64"
    CLValueBytesParsers::CLI64BytesParser.to_bytes(value)
  when "U8"
    CLValueBytesParsers::CLU8BytesParser.to_bytes(value)
  when "U32"
    CLValueBytesParsers::CLU32BytesParser.to_bytes(value)
  when "U64"
    CLValueBytesParsers::CLU64BytesParser.to_bytes(value)
  when "U128"
    CLValueBytesParsers::CLU128BytesParser.to_bytes(value)
  when "U256"
    CLValueBytesParsers::CLU256BytesParser.to_bytes(value)
  when "U512"
    CLValueBytesParsers::CLU512BytesParser.to_bytes(value)
  when "Unit"
    CLValueBytesParsers::CLUnitBytesParser.to_bytes(value)
  when "String"
    CLValueBytesParsers::CLUnitBytesParser.to_bytes(value)
  # when "Key"
  # when "URef"
  # when "Option"
  # when "List"
  # when "ByteArray"
  # when "Result"
  # when "Map"
  # when "Tuple1"
  # when "Tuple2"
  # when "Tuple3"
  # when "Any"
  # when "PublicKey"
  else
    "Unknown"
  end
end