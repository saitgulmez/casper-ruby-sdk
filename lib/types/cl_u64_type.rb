require_relative './cl_type.rb'
require_relative './constants.rb'


class CLU64Type < CLType
  def initialize(value = nil)  
    super(value)
    @value = value
  end

  def to_string
    # U64_ID
    TAGS.key(5).to_s
  end

  def get_value 
    @value
  end

  def to_json 
    to_string
  end
end