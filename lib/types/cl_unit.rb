require_relative './cl_unit_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'



class CLUnit < CLValue  
  # include CLValueBytesParsers::CLUnitBytesParser
 
  def initialize(value = nil)
    raise "error"  unless value.nil?
    super
    @value =  nil
    @h = {}
  end

  def get_cl_type
    @cl_type = CLUnitType.new
    @cl_type.to_string
  end

  def get_value
    @value
  end

  def to_json
    {"bytes": "", "cl_type": get_cl_type}.to_json
  end

  def from_json(json)
    JSON.parse(json)
  end

  def get_hash
    @h = {"bytes"=> "", "cl_type"=>get_cl_type}
  end
end

