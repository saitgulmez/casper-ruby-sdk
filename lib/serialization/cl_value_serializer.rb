require_relative '../types/cl_type.rb'
require_relative '../types/cl_bool.rb'
require_relative '../types/cl_i32.rb'
require_relative '../types/cl_i64.rb'
require_relative '../types/cl_u8.rb'
require_relative '../types/cl_u32.rb'
require_relative '../types/cl_u64.rb'
require_relative '../types/cl_u128.rb'
require_relative '../types/cl_u256.rb'
require_relative '../types/cl_u512.rb'
require_relative '../types/cl_unit.rb'
require_relative '../types/cl_tuple.rb'
require_relative '../types/cl_uref.rb'
require_relative '../types/cl_option.rb'
require_relative '../types/cl_string.rb'
# require_relative '../types/cl_key.rb'
require_relative '../types/cl_uref.rb'
require_relative '../types/cl_tuple.rb'
require_relative '../types/cl_public_key.rb'
require_relative '../types/constants.rb'
require_relative './cl_value_bytes_parsers.rb'
require_relative '../utils/byte_utils.rb'

# Byte serializer for CLValue
class CLValueSerializer
  def to_byte_array(num)
    result = []
    begin
      result << (num & 0xff)
      num >>= 8
    end until (num == 0 || num == -1) && (result.last[7] == num[7])
    # result.reverse
    result
  end

  def to_bytes(clvalue)
    type = clvalue.get_cl_type
    value = clvalue.get_value
    tag = CLType::TAGS[type.to_sym]

    serialized = ""
    if type == "Bool"
      [1].pack("L<*").unpack1("H*") + [value.to_i].pack("C*").unpack1("H*") + [tag].pack("C*").unpack1("H*")
    elsif type == "I32"
      [4].pack("L<*").unpack1("H*") + [value].pack("l<*").unpack1("H*") + [tag].pack("C*").unpack1("H*")
    elsif type == "I64"
      [8].pack("L<*").unpack1("H*") + [value].pack("q<*").unpack1("H*") + [tag].pack("C*").unpack1("H*")
    elsif type == "U8"
      [1].pack("L<*").unpack1("H*") + [value].pack("C*").unpack1("H*") + [tag].pack("C*").unpack1("H*")
    elsif type == "U32"
      serialized += [4].pack("L<*").unpack1("H*") + [value].pack("L<*").unpack1("H*") + [tag].pack("C*").unpack1("H*")
    elsif type == "U64"
      [8].pack("L<*").unpack1("H*") + [value].pack("Q<*").unpack1("H*") + [tag].pack("C*").unpack1("H*")
    elsif type == "U128"
      [8].pack("L<*").unpack1("H*")
    elsif type == "U256"
      [8].pack("L<*").unpack1("H*")
    elsif type == "U512"
      bytes = Utils::ByteUtils.byte_array_to_hex(to_byte_array(value))[0...-2]
      num_of_bytes = bytes.length/2
      [num_of_bytes+1].pack("L<*").unpack1("H*") + [num_of_bytes].pack("C*").unpack1("H*") + bytes +  [tag].pack("C*").unpack1("H*")
    elsif type == "Unit"
      [0].pack("L<*").unpack1("H*") + [tag].pack("C*").unpack1("H*")
    elsif type == "String"
      length = CLValueBytesParsers::CLStringBytesParser.to_bytes(value).length
      [length/2].pack("L<*").unpack1("H*") + CLValueBytesParsers::CLStringBytesParser.to_bytes(value) + [tag].pack("C*").unpack1("H*")
    elsif type == "Key"
      [11].pack("C*").unpack1("H*")
    elsif type == "URef"
      uref = clvalue.get_value
      size = clvalue.to_bytes(uref).length/2
      [size].pack("L<*").unpack1("H*") + clvalue.to_bytes(uref) + [tag].pack("C*").unpack1("H*")
    elsif type == "Option"
=begin
      # Solution 1, If we choose 
      #  CLOption.new(data, inner_type) = CLOption.new({ "cl_type": inner_type, "bytes": bytes, "parsed": parsed), "U64")
      inner_type = value[:cl_type]
      bytes = value[:bytes]
      parsed = value[:parsed]
      data = { "cl_type": inner_type, "bytes": bytes, "parsed": parsed}
      serialize_option_cl_value(data)
=end
      inner_clvalue = value # => CLu64.new(1)
      inner_value = value.get_value
      inner_type = value.get_cl_type
      # or
      # inner_type = clvalue.get_inner_type

      # puts "inner_clvalue  #{inner_clvalue}"
      inner_type = clvalue.get_inner_type # => or
      inner_type = value.get_cl_type
      # puts "inner_type = #{inner_type}"
      # puts inner_value
      bytes = Utils::ByteUtils.to_u64(inner_value)
      bytes  = "01" + bytes
      length = bytes.size/2
      tag = CLType::TAGS[inner_type.to_sym] 
      [length].pack("L<*").unpack1("H*") + bytes + "0d" + [tag].pack("C*").unpack1("H*")
    elsif type == "List"
      [0].pack("L<*").unpack1("H*")
    elsif type == "ByteArray"
      [0].pack("L<*").unpack1("H*")
    elsif type == "Result"
      [0].pack("L<*").unpack1("H*")
    elsif type == "Map"
      [0].pack("L<*").unpack1("H*")
    elsif type == "Tuple1"
      clvalue1 = clvalue.get_value[0]
      type1 = clvalue1.get_cl_type
      value1 = clvalue1.get_value
      tag1 = CLType::TAGS[type1.to_sym]
      serialized +=  helper(clvalue.get_value[0]) + [tag].pack("C*").unpack1("H*") + [tag1].pack("C*").unpack1("H*")
    elsif type == "Tuple2"
      clvalue1 = clvalue.get_value[0]
      type1 = clvalue1.get_cl_type
      value1 = clvalue1.get_value
      tag1 = CLType::TAGS[type1.to_sym]
      
      clvalue2 = clvalue.get_value[1]
      type2 = clvalue2.get_cl_type
      value2 = clvalue2.get_value
      tag2 = CLType::TAGS[type2.to_sym]
      
      len = only_length(clvalue.get_value[0]) + only_length(clvalue.get_value[1]) 
      [len].pack("L<*").unpack1("H*") +  only_value(clvalue.get_value[0]) + only_value(clvalue.get_value[1]) +
      [tag].pack("C*").unpack1("H*") + [tag1].pack("C*").unpack1("H*") + [tag2].pack("C*").unpack1("H*")
    elsif type == "Tuple3"
      clvalue1 = clvalue.get_value[0]
      type1 = clvalue1.get_cl_type
      value1 = clvalue1.get_value
      tag1 = CLType::TAGS[type1.to_sym]
      
      clvalue2 = clvalue.get_value[1]
      type2 = clvalue2.get_cl_type
      value2 = clvalue2.get_value
      tag2 = CLType::TAGS[type2.to_sym]      
     
      clvalue3 = clvalue.get_value[2]
      type3 = clvalue3.get_cl_type
      value3 = clvalue3.get_value
      tag3 = CLType::TAGS[type3.to_sym]
      
      len = only_length(clvalue.get_value[0]) + only_length(clvalue.get_value[1]) + only_length(clvalue.get_value[2])  
      [len].pack("L<*").unpack1("H*") +  only_value(clvalue.get_value[0]) + only_value(clvalue.get_value[1]) +  only_value(clvalue.get_value[2]) +
      [tag].pack("C*").unpack1("H*") + [tag1].pack("C*").unpack1("H*") + [tag2].pack("C*").unpack1("H*") + [tag3].pack("C*").unpack1("H*")
    elsif type == "Any"
      [0].pack("L<*").unpack1("H*")
    elsif type == "PublicKey"
      [clvalue.to_hex.length/2].pack("L<*").unpack1("H*") + clvalue.to_hex + [tag].pack("C*").unpack1("H*")
    else
      "Undefined"
    end
  end

  def helper(clvalue)
    type = clvalue.get_cl_type
    value = clvalue.get_value
    serialized = ""
    if type == "Bool"
      [1].pack("L<*").unpack1("H*") + [value.to_i].pack("C*").unpack1("H*")
    elsif type == "I32"
      [4].pack("L<*").unpack1("H*") + [value].pack("l<*").unpack1("H*")
    elsif type == "I64"
      [8].pack("L<*").unpack1("H*") + [value].pack("q<*").unpack1("H*")
    elsif type == "U8"
      [1].pack("L<*").unpack1("H*") + [value].pack("C*").unpack1("H*")
    elsif type == "U32"
      # serialized += [4].pack("L<*").unpack1("H*") + [value].pack("L<*").unpack1("H*")
      [4].pack("L<*").unpack1("H*") + [value].pack("L<*").unpack1("H*")
    elsif type == "U64"
      [8].pack("L<*").unpack1("H*") + [value].pack("Q<*").unpack1("H*")
    elsif type == "U128"
      [8].pack("L<*").unpack1("H*")
    elsif type == "U256"
      [8].pack("L<*").unpack1("H*")
    elsif type == "U512"
      bytes = [value].pack("Q<*").unpack1("H*")
      bytes = bytes[0, 8]
      [8].pack("Q<*").unpack1("H*")
    elsif type == "Unit"
      [9].pack("C*").unpack1("H*")
    elsif type == "String"
      length = CLValueBytesParsers::CLStringBytesParser.to_bytes(value).length
      [length/2].pack("L<*").unpack1("H*") + CLValueBytesParsers::CLStringBytesParser.to_bytes(value)
    elsif type == "Key"
      [11].pack("C*").unpack1("H*")
    elsif type == "URef"
      uref = clvalue.get_value
      size = clvalue.to_bytes(uref).length/2
      [size].pack("L<*").unpack1("H*") + clvalue.to_bytes(uref)
    elsif type == "Option"
      [0].pack("L<*").unpack1("H*")
    elsif type == "List"
      [0].pack("L<*").unpack1("H*")
    elsif type == "ByteArray"
      [0].pack("L<*").unpack1("H*")
    elsif type == "Result"
      [0].pack("L<*").unpack1("H*")
    elsif type == "Map"
      [0].pack("L<*").unpack1("H*")
    else
      "Undefined"
    end
  end

  def only_length(clvalue)
    type = clvalue.get_cl_type
    value = clvalue.get_value
    if type == "Bool"
      1
    elsif type == "I32"
      4
    elsif type == "I64"
      8
    elsif type == "U8"
      1
    elsif type == "U32"
      4
    elsif type == "U64"
      8
    elsif type == "U128"
      8
    elsif type == "U256"
      8
    elsif type == "U512"
      8
    elsif type == "Unit"
      8
    elsif type == "String"
      4 + value.length
    elsif type == "Key"
      32
    elsif type == "URef"
      uref = clvalue.get_value
      size = clvalue.to_bytes(uref).length/2
    elsif type == "Option"
      8
    elsif type == "List"
      8
    elsif type == "ByteArray"
      8
    elsif type == "Result"
      8
    elsif type == "Map"
      8
    else
      0
    end
  end
  def only_value(clvalue)
    type = clvalue.get_cl_type
    value = clvalue.get_value
    if type == "Bool"
      [value.to_i].pack("C*").unpack1("H*")
    elsif type == "I32"
      [value].pack("l<*").unpack1("H*")
    elsif type == "I64"
      [value].pack("q<*").unpack1("H*")
    elsif type == "U8"
      [value].pack("C*").unpack1("H*")
    elsif type == "U32"
      [value].pack("L<*").unpack1("H*")
    elsif type == "U64"
      [value].pack("Q<*").unpack1("H*")
    elsif type == "U128"
      [value].pack("Q<*").unpack1("H*")
    elsif type == "U256"
      [value].pack("Q<*").unpack1("H*")
    elsif type == "U512"
      [value].pack("Q<*").unpack1("H*")
    elsif type == "Unit"
      [value].pack("C*").unpack1("H*")
    elsif type == "String"
      CLValueBytesParsers::CLStringBytesParser.to_bytes(value)
    elsif type == "Key"
      [value].pack("C*").unpack1("H*")
    elsif type == "URef"
      uref = clvalue.get_value
      clvalue.to_bytes(uref)
    elsif type == "Option"
      [0].pack("L<*").unpack1("H*")
    elsif type == "List"
      [0].pack("L<*").unpack1("H*")
    elsif type == "ByteArray"
      [0].pack("L<*").unpack1("H*")
    elsif type == "Result"
      [0].pack("L<*").unpack1("H*")
    elsif type == "Map"
      [0].pack("L<*").unpack1("H*")
    else
      "Undefined"
    end
  end

  def serialize_option_cl_value(data) 
    
=begin
    # Solution 1
    # puts "\nOption:"
    cl_type = data[:cl_type]
    bytes = data[:bytes]
    parsed = data[:parsed]

    if cl_type == "U64"
      length = bytes.length/2
      # puts length
      bytes = bytes[2..]
      value = Utils::ByteUtils.hex_to_u64_value(bytes)
      # puts value == 1650706686882
      clvalue = CLu64.new(value)
      tag = CLType::TAGS[cl_type.to_sym]
      # puts "U64: " + [length].pack("L<*").unpack1("H*") + "01" + bytes + "0d" + [tag].pack("C*").unpack1("H*")
      [length].pack("L<*").unpack1("H*") + "01" + bytes + "0d" + [tag].pack("C*").unpack1("H*")
    end
=end
  end
end 