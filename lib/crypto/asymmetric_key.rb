require_relative '../utils/base_16.rb'
require_relative '../types/cl_public_key.rb'
require_relative '../utils/hex_utils.rb'
require_relative '../utils/hash_utils.rb'

CLPublicKeyTag = {
  ED25519: 1,
  SECP256K1: 2
}

SignatureAlgorithm = {
  Ed25519: 'ed25519',
  Secp256K1: 'secp256k1'
}

class AsymmetricKey
  attr_reader :public_key, :private_key, :signature_algorithm
  include Utils::HashUtils
  # @param [CLPublicKey] public_key
  # @param [Array] private_key
  # @param [SignatureAlgorithm] signature_algorithm
  def initialize(public_key, private_key, signature_algorithm)
    @public_key = public_key
    @private_key = private_key
    @signature_algorithm = signature_algorithm
    @tag = @public_key.get_cl_public_key_tag
  end

  # @return [CLPublicKey]
  def get_public_key
    @public_key
  end

  def get_signature_algorithm
    @signature_algorithm
  end

  # Get public hex-encoded string
  #
  # @return [String]
  def get_public_key_hex
   "0#{@tag}" + Utils::Base16.encode16(@public_key.get_value)
  end

  # @param [CLPublicKey] public_key
  # @return [String] account_hex
  def account_hex(public_key)
    account_hex = @public_key.to_hex
  end

  # @return [Array<Integer>] 
  def account_hash
    @tag = @public_key.get_cl_public_key_tag
    key_name = CLPublicKeyTag.key(@tag).to_s
    prefix = key_name.downcase.unpack("C*") + [0]
    bytes = prefix + @public_key.get_value
    result_array = Utils::HashUtils.byte_hash(bytes)
    @public_key.get_value.length == 0 ? [] : result_array
    # @public_key.to_account_hash_byte_array
  end
 
  # @param [String] path_to_private_key
  def create_from_private_key_file(path_to_private_key)
  end

  # Get public key which is stored in pem
  def export_public_key_in_pem
  end

  # @param [String] message
  # @return [String]
  def sign(message)
  end


  # @param [String] signature
  # @param [String] message
  # @return [Boolean]
  def verify(signature, message) 
  end
 
  protected
    attr_accessor :private_key

    def to_pem(tag, content) 
    end
end
