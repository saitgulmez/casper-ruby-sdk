require 'openssl'
require 'ed25519'
require 'blake2b'
require 'chilkat'

# CLPublicKeyTag = {
#   ED25519: 1,
#   SECP256K1: 2
# }

# ED25519 private key length in bytes
PRIVATE_KEY_LENGTH = 32

class Ed25519Key
  # attr_reader :public_key, :private_key, :signature_algorithm
  attr_accessor :public_key_hex, :signature_algorithm, :privKey, :private_key_hex
  # attr_reader :private_key_hex, :privKey
  include Utils::HashUtils

  def initialize()
    # file_path = "#{Dir.home}/ed25519_secret_key.pem"
    @file_path = "#{Dir.home}/ed25519_secret_key.pem"
    @privKey = Chilkat::CkPrivateKey.new()

    # This loads an Ed25519 key from an unencrypted PEM file (no password required).
    success = @privKey.LoadAnyFormatFile(@file_path,"")
    if (success == false)
      print @privKey.lastErrorText() + "\n";
      exit
    end

    @signature_algorithm = @privKey.keyType()

    # 32-byte (256-bit)
    @private_key_bit_length = @privKey.get_BitLength

    # Get the private and public key parts in raw hex format
    sbPubKeyHex = Chilkat::CkStringBuilder.new()

    @private_key_hex = @privKey.getRawHex(sbPubKeyHex)
    
    @public_key_hex = sbPubKeyHex.getAsString()

    success = @privKey.LoadEd25519(@private_key_hex, @public_key_hex)
    if (success == false)
        print @privKey.lastErrorText() + "\n";
        exit
    end
  end

  def get_public_key
    raise ArgumentError, "Expected a 64 character hex String" unless @public_key_hex.length == 64
     return "01" + @public_key_hex
  end

  def sign(message)
    success = @privKey.LoadEd25519(@private_key_hex, @public_key_hex)
    if (success == false)
        print @privKey.lastErrorText() + "\n";
        exit
    end
    @message = message
    # @message = Utils::ByteUtils.hex_to_byte_array(@message)


    byteData = Chilkat::CkByteData.new()
    byteData.appendEncoded(@message, "hex");

    @bd = Chilkat::CkBinData.new()
    @bd.AppendBinary(byteData)
    
    @signer = Chilkat::CkEdDSA.new()
    @signature = @signer.signBdENC(@bd, "hexlower", @privKey)
    if @signature_algorithm == "ed25519"
      @prefix = "0#{CLPublicKeyTag[:ED25519]}"
      @signature = @prefix + @signature 
    end
     @signature
  end

  # Verify the signature
  def verify(signature, message)
    pubKey = Chilkat::CkPublicKey.new()
    success = pubKey.LoadEd25519(@public_key_hex)
    if (success == false)
        print pubKey.lastErrorText() + "\n";
        exit
    end
    # Remove prefix "01"
    signature = signature[2...]
    verified = @signer.VerifyBdENC(@bd, signature, "hex", pubKey);
    if (verified == false)
        print @signer.lastErrorText() + "\n";
        print "Failed to verify the signature." + "\n";
        exit
    end
    return true

  end

  def public_key
    if @signature_algorithm == "ed25519" && @private_key_hex.length == 64
      prefix = "01"
      @public_key = prefix + @public_key_hex
    end
  end

  # @param [Array] public_key
  # @return [String]
  # def self.account_hex(public_key)
  #   '01' + Utils::Base16.encode16(public_key)
  # end

  # @param [String] private_key_path
  def create_from_private_key_file(private_key_path)

  end

  def export_public_key_in_pem
  end

  def export_private_key_in_pem
  end


  def private_to_public_key(private_key)
  end

  def parse_private_key(private_key)
  end
  
end

