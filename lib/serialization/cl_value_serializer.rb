require_relative '../types/cl_type.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'

class CLValueSerializer

  def to_bytes(clvalue)
    type = clvalue.get_cl_type
    value = clvalue.get_value
    tag = CLType::TAGS[type.to_sym]
    puts type
    # puts value
    # puts CLType::TAGS[type.to_sym]
    # puts tag
    [1].pack("L<*").unpack1("H*")
    if type == "Bool"
      [1].pack("L<*").unpack1("H*") + [value.to_i].pack("C*").unpack1("H*") + [tag].pack("C*").unpack1("H*")
    elsif type == "I32"
      [4].pack("L<*").unpack1("H*") + [value].pack("l<*").unpack1("H*") + [tag].pack("C*").unpack1("H*")
    elsif type == "I64"
      [8].pack("L<*").unpack1("H*") + [value].pack("q<*").unpack1("H*") + [tag].pack("C*").unpack1("H*")
    elsif type == "U8"
      [1].pack("L<*").unpack1("H*") + [value].pack("C*").unpack1("H*") + [tag].pack("C*").unpack1("H*")
    elsif type == "U32"
      [4].pack("L<*").unpack1("H*") + [value].pack("L<*").unpack1("H*") + [tag].pack("C*").unpack1("H*")
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
      [18].pack("C*").unpack1("H*") + cl_type.get_data[0].to_bytes
    elsif type == "Tuple2"
      [19].pack("C*").unpack1("H*") + cl_type.get_data[0].to_bytes + cl_type.get_data[1].to_bytes
    elsif type == "Tuple3"
      [20].pack("C*").unpack1("H*") + cl_type.get_data[0].to_bytes + cl_type.get_data[1].to_bytes + cl_type.get_data[2].to_bytes
    elsif type == "Any"
      [0].pack("L<*").unpack1("H*")
    elsif type == "PublicKey"
      [clvalue.to_hex.length/2].pack("L<*").unpack1("H*") + clvalue.to_hex + [tag].pack("C*").unpack1("H*")
    else
      "Undefined"
    end
  end
end