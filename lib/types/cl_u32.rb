require_relative './cl_u32_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'



class CLu32 < CLValue  
  include CLValueBytesParsers::CLU32BytesParser
 
  def initialize(value)
    raise "error"  unless value.instance_of? Integer
    super
    @value =  value
  end

  def get_cl_type
    @cl_type = CLU32Type.new
    @cl_type.to_string
  end

  def get_value
    @value  
  end

end

