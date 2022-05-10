require_relative './cl_tuple_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'
require_relative './cl_bool.rb'



class CLTuple < CLValue  
  # include CLValueBytesParsers::CLTupleBytesParser
 
  def initialize(size, array)
    super()
    if array.size > size
      raise "Too many elements!" 
    end
    if array.all? { |item| item.is_a?(CLValue)}
      @size = size
      @array = array
    else
      raise "Invalid data type(s) provided."
    end
  end

  def get_cl_type
    if @size == 1 && @array.size == 1
      @cl_type = CLTuple1Type.new
      @cl_type.to_string
    elsif @size == 2 && @array.size == 2
      @cl_type = CLTuple2Type.new
      @cl_type.to_string
    elsif @size == 3 && @array.size == 3
      @cl_type = CLTuple3Type.new
      @cl_type.to_string
    else
      raise "Invalid Type"
    end
  end

  def get_data
    @array  
  end

  def get_item(index)
    if index >= @size
      raise "Tuple index out of bounds."
    end
    @array[index]
  end

  def get_size
    @size
  end

end
