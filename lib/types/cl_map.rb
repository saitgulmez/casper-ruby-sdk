require_relative './cl_map_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'



class CLMap < CLValue  
  include CLValueBytesParsers::CLMapBytesParser
 
  def initialize(value = nil)
    super
    @value =  value
  end

  def get_cl_type
    @cl_type = CLMapType.new
    @cl_type.to_string
  end

  def get_value
    @value  
  end

end

