require_relative './cl_type.rb'
require_relative './constants.rb'


class CLTupleType < CLType
  def initialize(array = nil)  
    @array = array
  end

  def to_string
    if @array.size == 1
      @cl_type = CLTuple1Type.new
      @cl_type.to_string
    elsif @array.size == 2
      @cl_type = CLTuple2Type.new
      @cl_type.to_string
    elsif @array.size == 3
      @cl_type = CLTuple3Type.new
      @cl_type.to_string
    else
      raise "Invalid Type"
    end
  end

  def get_data 
    @array
  end

  def to_json 
    to_string
  end
end


class CLTuple1Type < CLTupleType
  def initialize(value = nil)  
    @value = value
  end

  def to_string
    # TUPLE1_ID
    TAGS.key(18).to_s
  end

  def get_value 
    @value
  end

  def to_json 
    to_string
  end 
end

class CLTuple2Type < CLTupleType
  def initialize(value = nil)  
    @value = value
  end

  def to_string
    # TUPLE2_ID
    TAGS.key(19).to_s
  end

  def get_value 
    @value
  end

  def to_json 
    to_string
  end 
end

class CLTuple3Type < CLTupleType
  def initialize(value = nil)  
    @value = value
  end

  def to_string
    # TUPLE3_ID
    TAGS.key(20).to_s
  end

  def get_value 
    @value
  end

  def to_json 
    to_string
  end 
end


