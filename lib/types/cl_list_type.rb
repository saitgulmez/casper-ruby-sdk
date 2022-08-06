require_relative './cl_type.rb'
require_relative './constants.rb'


class CLListType < CLType
  def initialize(value = nil)  
    super(value)
    @value = value
  end

  def to_string
    TAGS.key(14).to_s
  end

  def get_value 
    @value
  end

  def to_json 
    to_string
  end

  def to_bytes
    [14].pack("C*").unpack1("H*")
  end
end