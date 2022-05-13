require_relative './cl_type.rb'
require_relative './constants.rb'


class CLI32Type < CLType
  def initialize(value = nil)  
    super(value)
    @value = value
  end

  def to_string
    # I32_ID
    TAGS.key(1).to_s
  end

  def get_value 
    @value
  end

  def to_json 
    to_string
  end
end