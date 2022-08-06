require_relative './cl_type.rb'
require_relative './constants.rb'


class CLU32Type < CLType
  def initialize(value = nil)  
    super(value)
    @value = value
  end

  def to_string
    # I32_ID
    TAGS.key(5).to_s
  end

  def get_value 
    @value
  end

  def to_json 
    to_string
  end

  def to_bytes
    [4].pack("C*").unpack1("H*")
  end
end