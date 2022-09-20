require_relative '../types/cl_bool_type.rb'
require_relative '../types/cl_bool.rb'
require_relative '../types/cl_i32_type.rb'
require_relative '../types/cl_i64_type.rb'
require_relative '../types/cl_u8_type.rb'
require_relative '../types/cl_u32_type.rb'
require_relative '../types/cl_u64_type.rb'
require_relative '../types/cl_u128_type.rb'
require_relative '../types/cl_u256_type.rb'
require_relative '../types/cl_u512_type.rb'
require_relative '../types/cl_unit_type.rb'
require_relative '../types/cl_string_type.rb'
require_relative '../types/cl_key_type.rb'
require_relative '../types/cl_option_type.rb'
require_relative '../types/cl_list_type.rb'
require_relative '../types/cl_byte_array_type.rb'
require_relative '../types/cl_result_type.rb'
require_relative '../types/cl_map_type.rb'
require_relative '../types/cl_tuple_type.rb'
require_relative '../types/cl_any_type.rb'
require_relative '../types/cl_public_key_type.rb'

# Byte serializer for CLType
class CLTypeSerizalizer

  def self.serialize_cl_type(cl_type)
    if cl_type.to_string == "Bool"
      [0].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "I32"
      [1].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "I64"
      [2].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "U8"
      [3].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "U32"
      [4].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "U64"
      [5].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "U128"
      [6].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "U256"
      [7].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "U512"
      [8].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "Unit"
      [9].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "String"
      [10].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "Key"
      [11].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "URef"
      [12].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "Option"
      [13].pack("C*").unpack1("H*") + serialize_cl_type(cl_type.get_inner_type)
    elsif cl_type.to_string == "List"
      [14].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "ByteArray"
      [15].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "Result"
      [16].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "Map"
      [17].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "Tuple1"
      [18].pack("C*").unpack1("H*") + cl_type.get_data[0].to_bytes
    elsif cl_type.to_string == "Tuple2"
      [19].pack("C*").unpack1("H*") + cl_type.get_data[0].to_bytes + cl_type.get_data[1].to_bytes
    elsif cl_type.to_string == "Tuple3"
      [20].pack("C*").unpack1("H*") + cl_type.get_data[0].to_bytes + cl_type.get_data[1].to_bytes + cl_type.get_data[2].to_bytes
    elsif cl_type.to_string == "Any"
      [21].pack("C*").unpack1("H*")
    elsif cl_type.to_string == "PublicKey"
      [22].pack("C*").unpack1("H*")
    else
      "Undefined"
    end
  end  
end