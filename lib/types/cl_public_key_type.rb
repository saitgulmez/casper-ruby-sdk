require_relative './cl_type.rb'
require_relative './constants.rb'


class CLPublicKeyType < CLType
  def initialize(value = nil)  
    super(value)
    @value = value
  end

  def to_string
    TAGS.key(22).to_s
  end

  def get_value 
    @value
  end

  def to_json 
    to_string
  end

  def to_bytes
    [22].pack("C*").unpack1("H*")
  end
end