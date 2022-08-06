require_relative './cl_type.rb'
require_relative './constants.rb'


class CLByteArrayType < CLType
  def initialize(value = nil)  
    super(value)
    @value = value
  end

  def to_string
    TAGS.key(15).to_s
  end

  def get_value 
    @value
  end

  def to_json 
    to_string
  end

  def to_bytes
    [15].pack("C*").unpack1("H*")
  end

end