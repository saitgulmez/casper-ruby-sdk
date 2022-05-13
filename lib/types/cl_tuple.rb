require_relative './cl_tuple_type.rb'
require_relative './cl_value.rb'
require_relative './error.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'



class CLTuple < CLValue  
  # include CLValueBytesParsers::CLTupleBytesParser
  attr_accessor :size, :data
  def initialize(size, data)
    super()
    @size = 0
    @data = []
    if data.size > size
      raise "Too many elements!" 
    end
    if data.all? { |item| item.is_a?(CLValue)}
      @size = size
      @data = data
    else
      Error.new("Invalid data type(s) provided.")
    end
  end

  def get_cl_type
    if @size == 1 && @data.size == 1
      @cl_type = CLTuple1Type.new
      @cl_type.to_string + " (" + @data[0].get_cl_type + ")"
    elsif @size == 2 && @data.size == 2
      @cl_type = CLTuple2Type.new
      @cl_type.to_string + " (" + @data[0].get_cl_type + ", " + @data[1].get_cl_type + ")"
    elsif @size == 3 && @data.size == 3
      @cl_type = CLTuple3Type.new
      @cl_type.to_string + " (" + @data[0].get_cl_type + ", " + @data[1].get_cl_type + ", " + @data[2].get_cl_type + ")"
    else
      Error.new("Invalid Type")
    end
  end

  def get_value
    @data  
  end

  def get_size
    @size
  end

  def get(index)
    if index >= @size
      Error.new("Tuple index out of bounds.")
    else
      @data[index]
    end
  end

  def set(index, item) 
    if index >= @size
      Error.new("Tuple index out of bounds.")
    else
      data[index] = item
    end
  end

  def push(item)
    if @data.size < @size
      @data.push(item)
    else
      Error.new("No more space in this tuple!")
    end
  end

end


class CLTuple1 < CLTuple
  
  def initialize(data)
    super(1, data)
  end

  def get_cl_type
    @cl_tuple_type = CLTuple1Type.new
    @cl_tuple_type.to_string
  end
end

class CLTuple2 < CLTuple
  
  def initialize(data)
    super(2, data)
  end

  # def get_cl_type
  #   @cl_tuple_type = CLTuple2Type.new
  #   @cl_tuple_type.to_string
  # end
end

class CLTuple3 < CLTuple
  
  def initialize(data)
    super(3, data)
  end

  # def get_cl_type
  #   @cl_tuple_type = CLTuple3Type.new
  #   @cl_tuple_type.to_string
  # end
end