require_relative './cl_unit_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'



class CLUnit < CLValue  
  # include CLValueBytesParsers::CLUnitBytesParser
 
  def initialize(value = nil)
    raise "error"  unless value.nil?
    super
    @value =  nil
  end

  def get_cl_type
    @cl_type = CLUnitType.new
    @cl_type.to_string
  end

  def get_value
    @value  
  end

  def to_json
    @hash = {"bytes": "", "cl_type": get_cl_type}
    @hash.to_json
  end

  def from_json(json)
    @hash = JSON.parse(json)
  end
end

