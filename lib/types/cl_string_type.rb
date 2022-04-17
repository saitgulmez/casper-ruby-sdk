require './cl_type.rb'
require './constants.rb'


class CLStringType < CLType

  def initialize(value = nil)
    super(value)
    @value = value
  end

  def to_string
    # STRING_ID
    TAGS.key(10).to_s
  end

  def get_value
    @value  
  end

  def to_json
    to_string
  end
end





