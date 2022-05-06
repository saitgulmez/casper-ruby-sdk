require_relative './cl_type.rb'
require_relative './constants.rb'


class CLUnitType < CLType
  def initialize(value = nil)  
    super(value)
    @value = value
  end

  def to_string
    # UNIT_ID
    TAGS.key(9).to_s
  end

  def get_value 
    @value
  end

end