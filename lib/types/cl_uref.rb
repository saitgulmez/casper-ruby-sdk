require_relative './cl_uref_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'
require 'json'


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

  def self.parse_uref_address(str)
    raise ArgumentError.new("Expected a string value of \'uref-\' ") unless str.start_with?("uref-")
    raise ArgumentError.new("Expected a value of 3") unless str[0..str.length-1].split('-', 3).size == 3
    raise ArgumentError.new("Expected a value of 32") unless str[0..str.length-1].split('-', 3)[1].length/2 == 32

    arr = str[0..str.length-1].split('-', 3)
    prefix = arr[0]
    uref_addr = arr[1]
    suffix = arr[2]
    uref_byte_length = uref_addr.length / 2

    decoded_addr = CLValueBytesParsers::CLURefBytesParser.decode_base_16(uref_addr)
    access_rights = suffix.to_i(8)
    # puts decoded_addr.inspect
    # puts access_rights
    raise ArgumentError.new("The value of \'access_rights\' is out of range. It must be >= 0 and <= 7. Received #{access_rights}") unless suffix.to_i(10).between?(0, 7)
    CLURef.new(decoded_addr, access_rights)
  end

  def self.to_json(uref)
    decoded_addr = uref.get_value
    # p decoded_addr
    access_rights = uref.get_access_rights
    decoded_addr_with_access_rights = CLValueBytesParsers::CLURefBytesParser.to_bytes(uref)
    # p decoded_addr_with_access_rights
    encoded_addr_with_access_rights = CLValueBytesParsers::CLURefBytesParser.encode_base_16(decoded_addr_with_access_rights)
    # p encoded_addr_with_access_rights
    json = {"bytes": encoded_addr_with_access_rights, "cl_type": uref.get_cl_type}.to_json
  end

  def self.from_json(json)
    parsed = JSON.parse(json).deep_symbolize_keys
    bytes = CLValueBytesParsers::CLURefBytesParser.decode_base_16(parsed[:bytes])
    decoded = bytes[0...-1]
    access_rights = bytes.pop
    CLURef.new(decoded, access_rights)
  end
end