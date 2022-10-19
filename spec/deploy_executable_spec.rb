require_relative '../lib/entity/deploy_named_argument.rb'
require_relative '../lib/serialization/deploy_named_arg_serializer.rb'
require_relative '../lib/entity/deploy_executable_item_internal.rb'
require_relative '../lib/entity/deploy_executable.rb'
require_relative '../lib/entity/stored_contract_by_hash.rb'
require_relative '../lib/entity/stored_contract_by_name.rb'
require_relative '../lib/entity/stored_versioned_contract_by_hash.rb'
require_relative '../lib/entity/stored_versioned_contract_by_name.rb'
require_relative '../lib/serialization/deploy_executable_serializer.rb'
require_relative '../lib/entity/deploy.rb'
require_relative '../lib/entity/deploy_hash.rb'
require_relative '../lib/entity/deploy_header.rb'
require_relative '../lib/entity/deploy_approval.rb'
require_relative '../lib/entity/deploy_info.rb'
require_relative '../lib/entity/deploy.rb'
require_relative '../lib/serialization/deploy_serializer.rb'


RSpec.describe Casper::Entity::DeployExecutable do
  # describe Casper::Entity::DeployExecutable do
  let(:args) {[]}

    
    # ModuleBytes
    describe Casper::Entity::ModuleBytes do
      it "ModuleBytes serialization" do
        args = []
        arg1 = Casper::Entity::DeployNamedArgument.new("amount", CLu512.new(2500000000))
        args << [arg1]
        module_bytes = Casper::Entity::ModuleBytes.new("", args)
        # puts Utils::ByteUtils.byte_array_to_hex(module_bytes.to_bytes)
        expect(Utils::ByteUtils.byte_array_to_hex(module_bytes.to_bytes)).to eql("00000000000100000006000000616d6f756e74050000000400f9029508")
      end
    end

    # StoredContractByHash
    describe Casper::Entity::StoredContractByHash do
      it "StoredContractByHash serialization" do 
        arg1 = Casper::Entity::DeployNamedArgument.new("quantity", CLi32.new(1000))
        args << [arg1]
        stored_contract_by_hash = Casper::Entity::StoredContractByHash.new("c4c411864f7b717c27839e56f6f1ebe5da3f35ec0043f437324325d65a22afa4", "pclphXwfYmCmdITj8hnh", args)
        # puts Utils::ByteUtils.byte_array_to_hex(stored_contract_by_hash.to_bytes)
        expect(Utils::ByteUtils.byte_array_to_hex(stored_contract_by_hash.to_bytes)).to eql("01c4c411864f7b717c27839e56f6f1ebe5da3f35ec0043f437324325d65a22afa41400000070636c7068587766596d436d6449546a38686e6801000000080000007175616e7469747904000000e803000001")
      end
    end

    # StoredContractByName
    describe Casper::Entity::StoredContractByName do
      it "StoredContractByName serialization" do
        arg1 = Casper::Entity::DeployNamedArgument.new("quantity", CLi32.new(1000))
        args << [arg1]
        stored_contract_by_name = Casper::Entity::StoredContractByName.new("casper-example", "example-entry-point", args)
        # puts Utils::ByteUtils.byte_array_to_hex(stored_contract_by_name.to_bytes)
        expect(Utils::ByteUtils.byte_array_to_hex(stored_contract_by_name.to_bytes)).to eql("020e0000006361737065722d6578616d706c65130000006578616d706c652d656e7472792d706f696e7401000000080000007175616e7469747904000000e803000001")
      end
    end

    # StoredVersionedContractByHash
    describe Casper::Entity::StoredVersionedContractByHash do
      it "StoredVersionedContractByHash serialization" do
        arg1 = Casper::Entity::DeployNamedArgument.new("test", CLString.new("Hello, World!"))
        args << [arg1]
        stored_versioned_contract_by_hash = Casper::Entity::StoredVersionedContractByHash.new("b348fdd0d0b3f66468687df93141b5924f6bb957d5893c08b60d5a78d0b9a423", nil, "PsLz5c7JsqT8BK8ll0kF", args)
        # puts Utils::ByteUtils.byte_array_to_hex(stored_versioned_contract_by_hash.to_bytes)
        expect(Utils::ByteUtils.byte_array_to_hex(stored_versioned_contract_by_hash.to_bytes)).to eql("03b348fdd0d0b3f66468687df93141b5924f6bb957d5893c08b60d5a78d0b9a423001400000050734c7a3563374a73715438424b386c6c306b46010000000400000074657374110000000d00000048656c6c6f2c20576f726c64210a")
      end
    end

    # StoredVersionedContractByName
    describe Casper::Entity::StoredVersionedContractByName do
      it "StoredVersionedContractByName serialization" do
        arg1 = Casper::Entity::DeployNamedArgument.new("test", CLString.new("Hello, World!"))
        args << [arg1]
        stored_versioned_contract_by_name = Casper::Entity::StoredVersionedContractByName.new("test-contract", nil, "PsLz5c7JsqT8BK8ll0kF", args)
        # puts Utils::ByteUtils.byte_array_to_hex(stored_versioned_contract_by_name.to_bytes)
        expect(Utils::ByteUtils.byte_array_to_hex(stored_versioned_contract_by_name.to_bytes)).to eql("040d000000746573742d636f6e7472616374001400000050734c7a3563374a73715438424b386c6c306b46010000000400000074657374110000000d00000048656c6c6f2c20576f726c64210a")
      end
    end

    # DeployExecutableTransfer
    describe Casper::Entity::DeployExecutableTransfer do
      it "DeployExecutableTransfer serialization" do
        arg1 = Casper::Entity::DeployNamedArgument.new("amount", CLi32.new(1000))
        args << [arg1]
        transfer = Casper::Entity::DeployExecutableTransfer.new(args)
        # puts Utils::ByteUtils.byte_array_to_hex(transfer.to_bytes)
        expect(Utils::ByteUtils.byte_array_to_hex(transfer.to_bytes)).to eql("050100000006000000616d6f756e7404000000e803000001")
      end
    end
end