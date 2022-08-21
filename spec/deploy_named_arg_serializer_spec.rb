require_relative '../lib/serialization/cl_value_serializer.rb'
require_relative '../lib/serialization/deploy_named_arg_serializer.rb'


describe DeployNamedArgSerializer do
  let (:serializer) { DeployNamedArgSerializer.new }
  
  describe "#to_bytes" do
    
    context "when DeployNamedArg has CLu32 value" do
      let (:arg)  { Casper::Entity::DeployNamedArgument.new("casper-testnet", CLu32.new(17)) }
      
      it "should serialize DeployNamedArg with CLString value" do
        expect(serializer.to_bytes(arg)).to eq("0e0000006361737065722d746573746e6574040000001100000004")
      end
    end
    
    context "when DeployNamedArg has CLString value" do
      let (:arg)  { Casper::Entity::DeployNamedArgument.new("casper-testnet", CLString.new("Hello, World!")) }
      
      it "should serialize DeployNamedArg with CLString value" do
        expect(serializer.to_bytes(arg)).to eq("0e0000006361737065722d746573746e6574110000000d00000048656c6c6f2c20576f726c64210a")
      end
    end
    
    context "when DeployNamedArg has CLURef value" do
      let (:uref)  { CLURef.new("uref-000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f-007") }
      let (:arg)  { Casper::Entity::DeployNamedArgument.new("casper-testnet", uref)}
      
      it "should serialize DeployNamedArg with CLURef value" do
        expect(serializer.to_bytes(arg)).to eq("0e0000006361737065722d746573746e657421000000000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f070c")
      end
    end
   
    context "when DeployNamedArg has CLPublicKey value" do
      let (:pub_key_hex_ed25519)  { "010af5a943bacd2a8e91792eb4e9a25e32d536ab103372f57f89ebcadfc59820d1" }
      let (:pub_raw_ed25519)      { [10, 245, 169, 67, 186, 205, 42, 142, 
                                    145, 121, 46, 180, 233, 162, 94, 50, 
                                    213, 54, 171, 16, 51, 114, 245, 127, 
                                    137, 235, 202, 223, 197, 152, 32, 209 ] }
      let (:cl_public_key)       { CLPublicKey.new(pub_raw_ed25519, CLPublicKeyTag[:ED25519]) }
      let (:arg)       { Casper::Entity::DeployNamedArgument.new("casper-testnet", cl_public_key) }
      
      it "should serialize DeployNamedArg with CLPublicKey value" do
        expect(serializer.to_bytes(arg)).to eq("0e0000006361737065722d746573746e657421000000010af5a943bacd2a8e91792eb4e9a25e32d536ab103372f57f89ebcadfc59820d116")
      end
    end
  end
end