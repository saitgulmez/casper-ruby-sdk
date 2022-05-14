require_relative './cl_tuple_type.rb'
require_relative './cl_value.rb'
require_relative './error.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'



class CLTuple < CLValue  
  include CLValueBytesParsers::CLTupleBytesParser
  attr_accessor :size, :data
  def initialize(size, data)
    super()
    @size = 0
    @data = []
    @all_members_are_clvalues = data.all? { |item| item.is_a?(CLValue)}

    if data.size > size && @all_members_are_clvalues
      begin
        raise Error.new("Too many elements!")
      rescue => e
        e.err
      end
    end
   
    if @all_members_are_clvalues && data.size == size
      @size = size
      @data = data
    else
      begin
        raise Error.new("Invalid data type(s) provided.")
      rescue => e
        e.err
      end
    end
  end

  def get_cl_type
    if @all_members_are_clvalues
      if @data.size == @size
        if @data.size == 1
          @cl_type = CLTuple1Type.new
          @cl_type.to_string + " (" + @data[0].get_cl_type + ")"
        elsif @data.size == 2
          @cl_type = CLTuple2Type.new
          @cl_type.to_string + " (" + @data[0].get_cl_type + ", " + @data[1].get_cl_type + ")"
        elsif @data.size == 3
          @cl_type = CLTuple3Type.new
          @cl_type.to_string + " (" + @data[0].get_cl_type + ", " + @data[1].get_cl_type + ", " + @data[2].get_cl_type + ")"
        else
          begin
            raise Error.new("Tuple is not defined!")
          rescue => e
            e.err
          end
        end          
      elsif @data.size > size
        begin
          raise Error.new("Too many elements!")
        rescue => e
          e.err
        end
      end
    else
      begin
        raise Error.new("Invalid data type(s) provided.")
      rescue => e
        e.err
      end
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

  # def get_cl_type
  #   @cl_tuple_type = CLTuple1Type.new
  #   @cl_tuple_type.to_string
  # end
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
    # puts data
  end

  # def get_cl_type
  #   @cl_tuple_type = CLTuple3Type.new
  #   @cl_tuple_type.to_string
  # end
end