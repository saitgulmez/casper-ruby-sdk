require_relative './cl_type.rb'

class CLValue

  def initialize(bytes = nil, cl_type =  nil, parsed = nil)
    @bytes = bytes
    @cl_type = cl_type
    @parsed = parsed
  end
end
