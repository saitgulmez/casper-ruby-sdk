require_relative './cl_u512_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'



class CLu512 < CLValue  
  include CLValueBytesParsers::CLU512BytesParser
 
  def initialize(value)
    raise "error"  unless value.instance_of? Integer
    super
    @value =  value
  end

  def get_cl_type
    @cl_type = CLU512Type.new
    @cl_type.to_string
  end

  def get_value
    @value  
  end

end

