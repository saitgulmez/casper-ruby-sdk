require_relative '../serialization/cl_value_bytes_parsers.rb'

def find_byte_parser_by_cl_type(type, value)
  if type == "Bool"
    CLValueBytesParsers::CLStringBytesParser.to_bytes(value)
  elsif type == "I32"
    CLValueBytesParsers::CLI32BytesParser.to_bytes(value)
  elsif type == "I64"
    CLValueBytesParsers::CLI32BytesParser.to_bytes(value)
  elsif type == "U8"
    CLValueBytesParsers::CLU8BytesParser.to_bytes(value)
  elsif type == "U32"
    CLValueBytesParsers::CLU32BytesParser.to_bytes(value)
  elsif type == "U64"
    CLValueBytesParsers::CLU64BytesParser.to_bytes(value)
  elsif type == "U128"
    CLValueBytesParsers::CLU128BytesParser.to_bytes(value)
  elsif type == "U256"
    CLValueBytesParsers::CLU256BytesParser.to_bytes(value)
  elsif type == "U512"
    CLValueBytesParsers::CLU512BytesParser.to_bytes(value)
  elsif type == "Unit"
    CLValueBytesParsers::CLUnitBytesParser.to_bytes(value)
  elsif type == "String"
    CLValueBytesParsers::CLStringBytesParser.to_bytes(value)
  elsif type == "Key"
    CLValueBytesParsers::CLKeyBytesParser.to_bytes(value)
  elsif type == "URef"
    CLValueBytesParsers::CLURefBytesParser.to_bytes(value)
  elsif type == "Option"
    CLValueBytesParsers::CLOptionBytesParser.to_bytes(value)
  elsif type == "List"
    CLValueBytesParsers::CLListBytesParser.to_bytes(value)
  elsif type == "ByteArray"
    CLValueBytesParsers::CLByteArrayBytesParser.to_bytes(value)
  elsif type == "Result"
    CLValueBytesParsers::CLResultBytesParser.to_bytes(value)
  elsif type == "Map"
    CLValueBytesParsers::CLMapBytesParser.to_bytes(value)
  elsif type == "Tuple1"
    CLValueBytesParsers::CLTupleBytesParser.to_bytes(value)
  elsif type == "Tuple2"
    CLValueBytesParsers::CLTupleBytesParser.to_bytes(value)
  elsif type == "Tuple3"
    CLValueBytesParsers::CLTupleBytesParser.to_bytes(value)
  elsif type == "Any"
    CLValueBytesParsers::CLAnyBytesParser.to_bytes(value)
  elsif type == "PublicKey"
    CLValueBytesParsers::CLPublicKeyBytesParser.to_bytes(value)
  else
    "Undefined type"
  end
end