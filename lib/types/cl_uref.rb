require_relative './cl_uref_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'

#  Access Rights
# https://docs.casperlabs.io/design/serialization-standard/#clvalue-uref


class CLURef < CLValue  
  include CLValueBytesParsers::CLURefBytesParser
  attr_accessor :err
  # @param [Array<Integer>]
  # value is an uint8array
  def initialize(value, access_rights)
    super()
    # raise ArgumentError.new('The length of URefAddr should be 32') unless value.length == 32
    # rescue ArgumentError => e
    #   p e.message
    begin
      raise ArgumentError.new('The length of URefAddr should be 32') unless value.length == 32
    rescue ArgumentError => e  
      e.message
    end
    begin
      raise ArgumentError.new('Unsupported AccessRights') unless AccessRights.has_value?(access_rights)
    rescue ArgumentError => e  
      e.message
    end
    # if value.length != 32
    #   raise ArgumentError.new('The length of URefAddr should be 32')
    # end
    # raise ArgumentError.new("Unsupported AccessRights") unless AccessRights.has_value?(access_rights)
    # if value.length != 32
    #   begin
    #     raise Error.new('The length of URefAddr should be 32')
    #   rescue StandardError => e
    #     puts e
    #   end
    # end
    # if !(AccessRights.has_value?(access_rights))
    #   raise Error.new('Unsupported AccessRights')
    # end
    @value =  value
    @access_rights = access_rights

  end

  def get_cl_type
    @cl_type = CLURefType.new
    @cl_type.to_string
  end

  def get_value
    @value 
  end

  def get_access_rights
    @access_rights
  end

  def get_size
    @value.size
  end

end

