require_relative './cl_i32_type.rb'
require_relative './cl_value.rb'



class CLI32 < CLValue  

  def initialize(value)
    super
    @value =  value
  end

  def get_cl_type
    @cl_type = CLI32Type.new
    @cl_type.to_string
  end

  def get_value
    @value  
  end

end

