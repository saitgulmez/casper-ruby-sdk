
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

  # @param [String] public_key
  # @param [String] private_key
  # @param [Integer] signature_algorithm
  def initialize(public_key, private_key, signature_algorithm)
    @public_key = public_key
    @private_key = private_key
    @signature_algorithm = signature_algorithm
  end

  def get_signature_algorithm
    @signature_algorithm
  end

  # Get public hex-encoded string
  #
  # @return [String]
  def get_public_key
    @public_key
  end

  def 

end
