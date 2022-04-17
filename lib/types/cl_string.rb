require './cl_string_type.rb'
require './cl_value.rb'


class CLString < CLValue
  attr_accessor :cl_value
  alias_method :clvalue?, :cl_value

  def initialize(value)
    super
    # raise "error" unless value.is_a?(String)
    raise "error" unless value.instance_of? String
    @value =  value
  end

  def get_cl_type
    @cl_string_type = CLStringType.new("cl-string-type")
  end

  def get_value
    @value  
  end

  def get_size
    @value.length
  end
end

