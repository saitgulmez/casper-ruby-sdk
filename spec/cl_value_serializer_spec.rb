require_relative '../lib/types/cl_bool.rb'
require_relative '../lib/types/cl_i32.rb'
require_relative '../lib/types/cl_i64.rb'
require_relative '../lib/types/cl_u8.rb'
require_relative '../lib/types/cl_u32.rb'
require_relative '../lib/types/cl_u64.rb'
require_relative '../lib/types/cl_u128.rb'
require_relative '../lib/types/cl_u256.rb'
require_relative '../lib/types/cl_u512.rb'
require_relative '../lib/types/cl_unit.rb'
require_relative '../lib/types/cl_tuple.rb'
require_relative '../lib/types/cl_uref.rb'
require_relative '../lib/types/cl_option.rb'
require_relative '../lib/types/cl_string.rb'
# require_relative '../lib/types/cl_key.rb'
require_relative '../lib/types/cl_uref.rb'
require_relative '../lib/types/cl_tuple.rb'
require_relative '../lib/types/cl_public_key.rb'
require_relative '../lib/types/constants.rb'
require_relative '../lib/serialization/cl_value_serializer.rb'
require_relative '../lib/serialization/cl_value_bytes_parsers.rb'
require 'json'

describe CLValueSerializer do 
  let (:serializer) { CLValueSerializer.new }

  describe "CLBool Value Serializer" do
    let (:bool1) { CLBool.new(false) }
    let (:bool2) { CLBool.new(true) }
 
    it "should serialize CLBool values" do
      expect(serializer.to_bytes(bool1)).to eq("010000000000")
      expect(serializer.to_bytes(bool2)).to eq("010000000100")
    end
  end

  describe "CLi32 Value Serializer" do 
    let (:i32_1) { CLi32.new(-10) }
    let (:i32_2) { CLi32.new(10) }

    it "should serialize CLi32 values" do
      expect(serializer.to_bytes(i32_1)).to eq("04000000f6ffffff01")
      expect(serializer.to_bytes(i32_2)).to eq("040000000a00000001")
    end
  end

  describe "CLi64 Value Serializer" do 
    let (:i64_1) { CLi64.new(-16) }
    let (:i64_2) { CLi64.new(16) }

    it "should serialize CLi64 values" do
      expect(serializer.to_bytes(i64_1)).to eq("08000000f0ffffffffffffff02")
      expect(serializer.to_bytes(i64_2)).to eq("08000000100000000000000002")
    end
  end

  describe "CLu8 Value Serializer" do 
    let (:u8_1) { CLu8.new(0x00) }
    let (:u8_2) { CLu8.new(0x7F) }

    it "should serialize CLu8 values" do
      expect(serializer.to_bytes(u8_1)).to eq("010000000003")
      expect(serializer.to_bytes(u8_2)).to eq("010000007f03")
    end
  end

  describe "CLu32 Value Serializer" do 
    
    MAX_U32 = 2.pow(32) - 1
    MIN_U32 = 0 
    let (:u32_1) { CLu32.new(MAX_U32) } 
    let (:u32_2) { CLu32.new(MIN_U32) }

    it "should serialize CLu32 values" do
      expect(serializer.to_bytes(u32_1)).to eq("04000000ffffffff04")
      expect(serializer.to_bytes(u32_2)).to eq("040000000000000004")
    end
  end

  describe "CLu64 Value Serializer" do 
    MAX_U64 = 2.pow(64) - 1
    MIN_U64 = 0
    let (:u64_1) { CLu64.new(MAX_U64) }
    let (:u64_2) { CLu64.new(1) }

    it "should serialize CLu64 values" do
      expect(serializer.to_bytes(u64_1)).to eq("08000000ffffffffffffffff05")
      expect(serializer.to_bytes(u64_2)).to eq("08000000010000000000000005")
    end
  end

  describe "CLString Value Serializer" do
    let (:str1) { CLString.new("Hello, Casper!") }
    it "should serialize CLString values" do
      expect(serializer.to_bytes(str1)).to eq("120000000e00000048656c6c6f2c20436173706572210a")
    end
  end
  
  describe "CLURef Value Serializer" do
    let (:uref) { "uref-000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f-007" }
    let (:clvalue) { CLURef.new(uref) }
    it "should serialize CLURef values" do
      expect(serializer.to_bytes(clvalue)).to eq("21000000000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f070c")
    end
  end

  describe "CLPublicKey Value Serializer" do
    let (:pub_key_hex_ed25519)  { "010af5a943bacd2a8e91792eb4e9a25e32d536ab103372f57f89ebcadfc59820d1" }
    let (:pub_raw_ed25519)  { [10, 245, 169, 67, 186, 205, 42, 142, 
                                145, 121, 46, 180, 233, 162,94, 50, 
                                213, 54, 171, 16, 51, 114, 245, 127, 137, 
                                235, 202, 223, 197, 152, 32, 209] }
    let (:clvalue)  { CLPublicKey.new(pub_raw_ed25519, CLPublicKeyTag[:ED25519]) }
    it "should serialize CLPublicKey values" do
      expect(serializer.to_bytes(clvalue)).to eq("21000000010af5a943bacd2a8e91792eb4e9a25e32d536ab103372f57f89ebcadfc59820d116")
    end
  end

  describe CLTuple do
    let (:bool)  { CLBool.new(true) }
    let (:u32_1) { CLu32.new(17) }
    let (:u32_2) { CLu32.new(127) }
    let (:str)   { CLString.new("ABCDE") }

    describe CLTuple1 do
        let (:tuple1) { CLTuple1.new([bool]) }
        let (:tuples) { [CLTuple1.new([bool]), CLTuple1.new([u32_1]), CLTuple1.new([str])] }
      it "should serialize CLTuple1" do
        expect(serializer.to_bytes(tuple1)).to eq("01000000011200")
        expect(serializer.to_bytes(tuples[0])).to eq("01000000011200")
        expect(serializer.to_bytes(tuples[1])).to eq("04000000110000001204")
        expect(serializer.to_bytes(tuples[2])).to eq("09000000050000004142434445120a")
      end
    end
    
    describe CLTuple2 do
        let (:tuples) { [CLTuple2.new([u32_1, u32_2]), CLTuple2.new([u32_2, str])] }
      it "should serialize CLTuple1" do
        expect(serializer.to_bytes(tuples[0])).to eq("08000000110000007f000000130404")
        expect(serializer.to_bytes(tuples[1])).to eq("0d0000007f00000005000000414243444513040a")
      end
    end
    
    describe CLTuple3 do
        let (:tuples) { [CLTuple3.new([u32_1, u32_2, u32_1]), CLTuple3.new([u32_2, str, u32_2])] }
      it "should serialize CLTuple1" do
        expect(serializer.to_bytes(tuples[0])).to eq("0c000000110000007f0000001100000014040404")
        expect(serializer.to_bytes(tuples[1])).to eq("110000007f0000000500000041424344457f00000014040a04")
      end
    end
  end
end