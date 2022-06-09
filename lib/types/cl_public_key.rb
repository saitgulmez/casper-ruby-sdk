require_relative './cl_public_key_type.rb'
require_relative './cl_value.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'
require_relative '../utils/base_16.rb'
require_relative '../utils/hex_utils.rb'
require_relative '../utils/hash_utils.rb'
require 'blake2'
=begin
PublicKey serializes as a single byte tag representing the algorithm followed by 32 bytes of the PublicKey itself:
If the PublicKey is an Ed25519 key, the single tag byte is 1 followed by the individual bytes of the serialized key.
If the PublicKey is a Secp256k1 key, the single tag byte is a 2 followed by the individual bytes of the serialized key.
=end
ED25519_LENGTH = 32
SECP256K1_LENGTH = 33


CLPublicKeyTag = {
  ED25519: 1,
  SECP256K1: 2
}
 
 SignatureAlgorithm = {
  Ed25519: 'ed25519',
  Secp256K1: 'secp256k1'
}




class CLPublicKey < CLValue  
  include CLValueBytesParsers::CLPublicKeyBytesParser
  include Utils::HashUtils
  # @param [Array<Integer>] raw_public_key
  # @param [Integer] tag
  def initialize(raw_public_key, tag)
    super()
    raw_public_key_length_valid?(raw_public_key, tag)
  end

  def raw_public_key_length_valid?(raw_public_key, tag)
    if tag == CLPublicKeyTag[:ED25519] || tag == SignatureAlgorithm[:Ed25519]
      if raw_public_key.length != ED25519_LENGTH
        raise ArgumentError.new("Wrong length of ED25519 key. Expected #{ED25519_LENGTH}, but got #{raw_public_key.length}")
      end
      @raw_public_key = raw_public_key
      @tag = tag
    elsif tag == CLPublicKeyTag[:SECP256K1] || tag == SignatureAlgorithm[:Secp256K1]
      if raw_public_key.length != SECP256K1_LENGTH
        raise ArgumentError.new("Wrong length of SECP256K1 key. Expected #{SECP256K1_LENGTH}, but got #{raw_public_key.length}")
      end
      @raw_public_key = raw_public_key
      @tag = tag
    else
      raise ArgumentError.new("Unsupported type of public key")
    end
  end

  def get_cl_type
    @cl_type = CLPublicKeyType.new
    @cl_type.to_string
  end


  def get_value
    @raw_public_key  
  end

  def get_cl_public_key_tag
    if @tag == CLPublicKeyTag[:ED25519] || @tag == SignatureAlgorithm[:Ed25519]
      CLPublicKeyTag[:ED25519]
    else
      CLPublicKeyTag[:SECP256K1] 
    end
  end

  def get_signature_algorithm
    if @tag == CLPublicKeyTag[:ED25519] || @tag == SignatureAlgorithm[:Ed25519]
      SignatureAlgorithm[:Ed25519]
    else
      SignatureAlgorithm[:Secp256K1]
    end
  end

  def ed25519?
    @tag == CLPublicKeyTag[:ED25519]
  end

  def secp256k1?
    @tag == CLPublicKeyTag[:SECP256K1]
  end

  # @return [Array<Integer>] 
  def to_account_hash_byte_array
    key_name = CLPublicKeyTag.key(@tag).to_s
    prefix = key_name.downcase.unpack("C*") + [0]
    bytes = prefix + @raw_public_key
    result_array = Utils::HashUtils.byte_hash(bytes)
    @raw_public_key.length == 0 ? [] : result_array
  end

  # @return [String] hex
  def to_account_hash_hex
    bytes = to_account_hash_byte_array
    hex = Utils::HashUtils.account_hash_from_byte_to_hex(bytes)
  end

  def from_ed25519(public_key)
    CLPublicKey.new(public_key, CLPublicKeyTag[:ED25519])
  end

  def self.from_ed25519(public_key)
    CLPublicKey.new(public_key, CLPublicKeyTag[:ED25519])
  end

  def from_secp256k1(public_key)
    CLPublicKey.new(public_key, CLPublicKeyTag[:SECP256K1])
  end

  def self.from_secp256k1(public_key)
    CLPublicKey.new(public_key, CLPublicKeyTag[:SECP256K1])
  end

  def to_hex
    # "0#{@tag}#{Utils::Base16.encode16(@raw_public_key)}"
    "0#{@tag}#{CLValueBytesParsers::CLPublicKeyBytesParser.encode_base_16(@raw_public_key)}"
  end
  
  def from_hex(public_key_hex)
    raise ArgumentError.new("Invalid public key") unless Utils::HexUtils.valid_public_key_format?(public_key_hex)
    public_key_hex_bytes = Utils::Base16.decode16(public_key_hex)
    CLPublicKey.new(public_key_hex_bytes.drop(1), public_key_hex_bytes[0])
  end

  def self.from_hex(public_key_hex)
    raise ArgumentError.new("Invalid public key") unless Utils::HexUtils.valid_public_key_format?(public_key_hex)
    public_key_hex_bytes = Utils::Base16.decode16(public_key_hex)
    CLPublicKey.new(public_key_hex_bytes.drop(1), public_key_hex_bytes[0])
  end

end
