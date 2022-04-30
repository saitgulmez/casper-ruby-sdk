require_relative './cl_string_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'


class CLString < CLValue
  attr_accessor :cl_value
  alias_method :clvalue?, :cl_value
  include CLValueBytesParsers::CLStringBytesParser

  def initialize(value)
    super
    # raise "error" unless value.is_a?(String)
    raise "error" unless value.instance_of? String
    @value =  value
  end

  def get_cl_type
    @cl_string_type = CLStringType.new
    @cl_string_type.to_string
  end

  def get_value
    @value  
  end

  def get_size
    @value.length
  end
end

