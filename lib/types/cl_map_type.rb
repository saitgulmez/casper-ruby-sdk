require_relative './cl_type.rb'
require_relative './constants.rb'


class CLMapType < CLType
  def initialize(value = nil)  
    super(value)
    @value = value
  end

  def to_string
    TAGS.key(17).to_s
  end

  def get_value 
    @value
  end

  def to_json 
    to_string
  end
end