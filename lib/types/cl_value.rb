require_relative './cl_type.rb'

# A Casper value, i.e. a value which can be stored and manipulated by smart contracts.
class CLValue

  def initialize(bytes = nil, cl_type =  nil, parsed = nil)
    @bytes = bytes
    @cl_type = cl_type
    @parsed = parsed
  end
end
