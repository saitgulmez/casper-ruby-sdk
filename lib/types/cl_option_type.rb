require_relative './cl_type.rb'
require_relative './constants.rb'


class CLOptionType < CLType
  def initialize(value = nil)  
    super(value)
    @value = value
  end

  def to_string
    TAGS.key(13).to_s
  end

  def get_value 
    @value
  end

  def to_json 
    to_string
  end
end