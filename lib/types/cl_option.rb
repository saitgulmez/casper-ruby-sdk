require_relative './cl_option_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'

=begin
https://doc.rust-lang.org/stable/std/option/
=end

class CLOption < CLValue  
  include CLValueBytesParsers::CLOptionBytesParser
  
  def initialize(data = nil, inner_type = nil)
    super
    @data =  data
    @inner_type = inner_type
    if data == nil && inner_type == nil
      raise ArgumentError.new("You had to assign innerType for None")
    elsif data == nil && inner_type != nil
      @inner_type = inner_type
    else
      @inner_type = data.get_cl_type
    end
  end
  
  def get_value
    @data
  end

  def get_cl_type
   CLOptionType.new(@inner_type)
   @inner_type
  end
end
