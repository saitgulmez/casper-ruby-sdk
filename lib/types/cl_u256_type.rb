require_relative './cl_type.rb'
require_relative './constants.rb'


class CLU256Type < CLType
  def initialize(value = nil)  
    super(value)
    @value = value
  end

  def to_string
    # U256_ID
    TAGS.key(7).to_s
  end

  def get_value 
    @value
  end

  def to_json 
    to_string
  end

  def to_bytes
    [7].pack("C*").unpack1("H*")
  end
end