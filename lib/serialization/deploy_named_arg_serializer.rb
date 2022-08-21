require_relative '../entity/deploy_named_argument.rb'
require_relative '../utils/find_byte_parser_by_cl_type.rb'
require_relative '../utils/byte_utils.rb'
require_relative './cl_type_serializer.rb'
require_relative './cl_value_serializer.rb'

class DeployNamedArgSerializer

  def to_bytes(arg)
    name = arg.get_name
    serialized_name = CLValueBytesParsers::CLStringBytesParser.to_bytes(name)
    clvalue = arg.get_value
    type = clvalue.get_cl_type
    
    serializer = CLValueSerializer.new
    serialized_value = serializer.to_bytes(clvalue)
    serialized_name + serialized_value
  end
end