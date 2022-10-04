require 'ed25519'
require 'blake2b'
require 'chilkat'
signing_key = Ed25519::SigningKey.generate
# puts "signing_key:\t #{signing_key}" 
# puts "seed:\t #{signing_key.seed}" 
# puts "keypair:\t #{signing_key.keypair}" 
# puts "verify_key:\t #{signing_key.verify_key}"
# serialized_deploy_to_hash = "dc7edd3dde249343bc379564724b3e30116d8d84702a589513728f2e09bcd167"
# signature = Ed25519.provider.sign("MC4CAQAwBQYDK2VwBCIEIKf7pd4LhteUsRPmagsm7by7YWZVM+thD/fWoP+QDZO7", serialized_deploy_to_hash)

# key = Blake2b::Key.none
# signature =  "01" + Blake2b.hex(signature, key, 64)
# puts signature
# message = "hello"
# signature = signing_key.sign(message)
# puts "signature:\t #{signature}"

# verify_key = signing_key.verify_key
# puts "verify_key:\t #{verify_key}"

# check_validity_of_signature = verify_key.verify(signature, message)
# puts "check_validity_of_signature:\t #{check_validity_of_signature}"

# # Serializing Keys
# signature_key_bytes = signing_key.to_bytes
# puts "signature_key_bytes:\t #{signature_key_bytes}"
# verify_key_bytes = verify_key.to_bytes
# puts "verify_key_bytes:\t #{verify_key_bytes}"

# signing_key = Ed25519::SigningKey.new(signature_key_bytes)
# puts "signing_key:\t #{signing_key}"
# verify_key  = Ed25519::VerifyKey.new(verify_key_bytes)
# puts "verify_key:\t #{verify_key}


#************************************************************************************************************


# Load an Ed25519 key
privKey = Chilkat::CkPrivateKey.new()

# Load an Ed25519 key from an unencrypted PEM file (no password required).
success = privKey.LoadAnyFormatFile("#{Dir.home}/Downloads/ed25519_secret_key.pem","")
if (success == false)
    print privKey.lastErrorText() + "\n";
    exit
end

# The key type should be "ed25519" to indicate an Ed25519 key.
print "key type = " + privKey.keyType() + "\n";
# key type = ed25519

# # What is the size of the private key in bits?  (should always be 256 bits for Ed25519)
print "size in bits = " + privKey.get_BitLength().to_s() + "\n";
# size in bits = 256

# # Get the private and public key parts in raw hex format:
sbPubKeyHex = Chilkat::CkStringBuilder.new()
privKeyHex = privKey.getRawHex(sbPubKeyHex)

# # We should have a 32-byte private key (a 64 character hex string).
print "private key = " + privKeyHex + "\n";
# private key = a7fba5de0b86d794b113e66a0b26edbcbb61665533eb610ff7d6a0ff900d93bb

# # We should have a 32-byte public key (a 64 character hex string).
print "public key = " + sbPubKeyHex.getAsString() + "\n";
# public key = ccee19366eaf03487cb81197ae8edcb1b47f214cee00d6597380096b9f8463c1



# This example assumes the Chilkat API to have been previously unlocked.
# See Global Unlock Sample for sample code.

privKeyHex = "a7fba5de0b86d794b113e66a0b26edbcbb61665533eb610ff7d6a0ff900d93bb"
pubKeyHex = "ccee19366eaf03487cb81197ae8edcb1b47f214cee00d6597380096b9f8463c1"

privKey = Chilkat::CkPrivateKey.new()
# This example shows only one way of loading an Ed25519 private key.
# Chilkat can load other formats (JWK, PEM, ASN.1 DER, etc.)  
# You may do so by calling LoadAnyFormat or LoadAnyFormatFile.
success = privKey.LoadEd25519(privKeyHex,pubKeyHex)
if (success == false)
    print privKey.lastErrorText() + "\n";
    exit
end

# The data to be signed...
bd = Chilkat::CkBinData.new()
deploy_hash = "633435d9660122917fd5b4de16b7f495959cd832b9ef293486c6893dc694ec26"
bd.AppendString(deploy_hash,"utf-8")
eddsa = Chilkat::CkEdDSA.new()
hexSig = eddsa.signBdENC(bd,"hexlower",privKey)

print "signature = " + "01" + hexSig + "\n";

# The expected output is: 016d49ac6138e556c9174c9c8e0d512bbb4697bbe3e96a28d8c1be83ea05c3a5945b6b87e4c974ae04e6cbcbac78bbbce672648444e269bdf30d27686fa03a440e

# # Verify the signature..
pubKey = Chilkat::CkPublicKey.new()
success = pubKey.LoadEd25519(pubKeyHex)
if (success == false)
    print pubKey.lastErrorText() + "\n";
    exit
end
puts pubKey
bVerified = eddsa.VerifyBdENC(bd,hexSig,"hexlower",pubKey)
if (bVerified == false)
    print eddsa.lastErrorText() + "\n";
    print "Failed to verify the signature." + "\n";
    exit
end

print "The Ed25519 signature is verified!" + "\n";