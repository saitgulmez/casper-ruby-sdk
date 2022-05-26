require_relative './cl_option_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'



class CLOption < CLValue  
  include CLValueBytesParsers::CLOptionBytesParser
 
  def initialize(value = nil)
    super
    @value =  value
  end

  def get_cl_type
    @cl_type = CLOptionType.new
    @cl_type.to_string
  end

  def get_value
    @value  
  end

end

