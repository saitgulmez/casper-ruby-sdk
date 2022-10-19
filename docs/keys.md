## Key management

Casper Ruby SDK provides following classes for key management:

- CLPublicKey : It is a class created for public key.

- Casper key management system supports two key algorithms:
    
    - ED25519
    - SECP256K1

- Ed25519Key : This class includes keypair for both Public and the associated private key.

    - Sign message 

    - Verify message

    - Read PrivateKey/PublicKey from PEM file

### Public Key

 - Create Public Key from byte array for ED25519

```ruby
pub_raw_ed25519 = [10, 245, 169, 67, 186, 205, 42, 142, 145, 121, 46, 180, 233, 162, 94, 50, 213, 54, 171, 16, 51, 114, 245, 127, 137, 235, 202, 223, 197, 152, 32, 209]
public_key_ed25519 = CLPublicKey.new(pub_raw_ed25519, CLPublicKeyTag[:ED25519])
```

 - Create Public Key from hex for ED25519

 ```ruby
public_key_hex = "01e23d200eb0f3c8a3dacc8453644e6fcf4462585a68234ebb1c3d6cc8971148c2"
public_key = CLPublicKey.from_hex(public_key_hex)
 ```

 - Create Public Key from byte array for SECP256K1

```ruby
pub_raw_secp256K1 = [74, 231, 213, 182, 107, 47, 208, 246, 111, 176, 239, 204, 238, 203, 103, 59, 55, 98, 89, 91, 48, 174, 28, 172, 72, 174, 143, 9, 211, 76, 149, 46, 228]
public_key_secp256K1 = CLPublicKey.new(pub_raw_secp256K1, CLPublicKeyTag[:SECP256K1])
```

 - Generate Public Key from hex for SECP256K1

 ```ruby
public_key_hex = "024ae7d5b66b2fd0f66fb0efcceecb673b3762595b30ae1cac48ae8f09d34c952ee4"
public_key = CLPublicKey.from_hex(public_key_hex)
 ```

- Ed25519Key

```ruby
key_pair = Ed25519Key.new()
message = "Hello World!"
key_pair.sign(message)
# => 018ac055916d9fdd0c8bf3332b4d28e034747ef7755a018c83a15ce160ce01054cae5201aad8d4c19406f44160251eb15df50c5fe4a3a7b9672bd41000c12eb70f
public_key_hex = key_pair.public_key_hex
# => ccee19366eaf03487cb81197ae8edcb1b47f214cee00d6597380096b9f8463c1
public_key_hex
public_ed25519 = key_pair.get_public_key
# => 01ccee19366eaf03487cb81197ae8edcb1b47f214cee00d6597380096b9f8463c1
public_ed25519
key_pair.private_key_hex
# => a7fba5de0b86d794b113e66a0b26edbcbb61665533eb610ff7d6a0ff900d93bb
key_pair.get_private_key_base_encoded_format("base64")
# => MC4CAQAwBQYDK2VuBCIEIKf7pd4LhteUsRPmagsm7by7YWZVM+thD/fWoP+QDZO7

```