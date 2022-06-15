require 'openssl'
require 'ed25519'
require_relative './asymmetric_key.rb'

# ED25519 private key length in bytes
PRIVATE_KEY_LENGTH = 32

class Ed25519Key < AsymmetricKey

  def initialize(public_key, private_key)
    super(public_key, private_key, SignatureAlgorithm[:Ed25519])
  end

  # @param [Array] public_key
  # @return [String]
  # def self.account_hex(public_key)
  #   '01' + Utils::Base16.encode16(public_key)
  # end


  def create_from_private_key_file(private_key_path)

  end

  def export_public_key_in_pem
  end

  def export_private_key_in_pem
  end

  def sign(msg)
  end

  def verify(signature, msg)
  end

  def private_to_public_key(private_key)
  end

  def parse_private_key(private_key)
  end
  
end

