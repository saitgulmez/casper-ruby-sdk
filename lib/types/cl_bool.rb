require_relative './cl_bool_type.rb'
require_relative './cl_value.rb'


module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end

class CLBool < CLValue  
  include Boolean
  def initialize(value)
    super
    raise "error" unless value.is_a?(Boolean)
    @value =  value
  end

  def get_cl_type
    @cl_bool_type = CLBoolType.new(true)
  end

  def get_value
    @value  
  end
end

