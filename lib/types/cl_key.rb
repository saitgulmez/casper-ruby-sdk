require_relative './cl_key_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'



class CLKey < CLValue  
  include CLValueBytesParsers::CLKeyBytesParser
 
  def initialize(value = nil)
    super
    @value =  value
  end

  def get_cl_type
    @cl_type = CLKeyType.new
    @cl_type.to_string
  end

  def get_value
    @value  
  end

end

