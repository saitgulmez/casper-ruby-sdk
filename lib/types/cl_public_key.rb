require_relative './cl_public_key_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'



class CLPublicKey < CLValue  
  include CLValueBytesParsers::CLPublicKeyBytesParser
 
  def initialize(value = nil)
    super
    @value =  value
  end

  def get_cl_type
    @cl_type = CLPublicKeyType.new
    @cl_type.to_string
  end

  def get_value
    @value  
  end

end

