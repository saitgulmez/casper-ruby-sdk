require 'openssl'
require 'ed25519'
require_relative './asymmetric_key.rb'

# SignatureAlgorithm = {
#   Ed25519: 'ed25519',
#   Secp256K1: 'secp256k1'
# }

class Ed25519Key < AsymmetricKey

  def initialize(public_key, private_key)
    super(public_key, private_key, SignatureAlgorithm[:Ed25519])
  end


  # @param [Array] public_key
  # @return [String]
  def account_hex(public_key)
    '01' + Utils::Base16.encode16(public_key)
  end
end
