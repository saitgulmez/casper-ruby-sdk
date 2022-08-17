require_relative '../types/cl_type.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'

class CLValueSerializer

  def to_bytes(clvalue)
    type = clvalue.get_cl_type
    value = clvalue.get_value
    tag = CLType::TAGS[type.to_sym]
    # puts type
    # puts value
    # puts CLType::TAGS[type.to_sym]
    puts tag
    [1].pack("L<*").unpack1("H*")
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
      [8].pack("L<*").unpack1("H*")
    elsif type == "Unit"
      [9].pack("C*").unpack1("H*")
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
      [0].pack("L<*").unpack1("H*")
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
      # [18].pack("C*").unpack1("H*") + cl_type.get_data[0].to_bytes
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
      serialized += [4].pack("L<*").unpack1("H*") + [value].pack("L<*").unpack1("H*")
    elsif type == "U64"
      [8].pack("L<*").unpack1("H*") + [value].pack("Q<*").unpack1("H*")
    elsif type == "U128"
      [8].pack("L<*").unpack1("H*")
    elsif type == "U256"
      [8].pack("L<*").unpack1("H*")
    elsif type == "U512"
      [8].pack("L<*").unpack1("H*")
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
end