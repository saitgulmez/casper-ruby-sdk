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

describe DeploySerializer do
  let(:byte_utils) { Utils::ByteUtils }
  let(:serializer) { DeploySerializer.new }
  it "should serialize Deploy" do
    serialized_deploy = "01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900ca856a4d37501000080ee36000000000001000000000000004811966d37fe5674a8af4001884ea0d9042d1c06668da0c963769c3a01ebd08f0100000001010101010101010101010101010101010101010101010101010101010101010e0000006361737065722d6578616d706c6501da3c604f71e0e7df83ff1ab4ef15bb04de64ca02e3d2b78de6950e8b5ee187020e0000006361737065722d6578616d706c65130000006578616d706c652d656e7472792d706f696e7401000000080000007175616e7469747904000000e803000001050100000006000000616d6f756e7404000000e8030000010100000001d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c012dbf03817a51794a8e19e0724884075e6d1fbec326b766ecfa6658b41f81290da85e23b24e88b1c8d9761185c961daee1adab0649912a6477bcd2e69bd91bd08"
    json_deploy = {
      "hash": "01da3c604f71e0e7df83ff1ab4ef15bb04de64ca02e3d2b78de6950e8b5ee187",
      "header": {
        "account": "01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c",
        "timestamp": "2020-11-17T00:39:24.072Z",
        "ttl": "1h",
        "gas_price": 1,
        "body_hash": "4811966d37fe5674a8af4001884ea0d9042d1c06668da0c963769c3a01ebd08f",
        "dependencies": [
        "0101010101010101010101010101010101010101010101010101010101010101"
        ],
        "chain_name": "casper-example"
      },
      "payment": {
        "StoredContractByName": {
          "name": "casper-example",
          "entry_point": "example-entry-point",
          "args": [
            [
              "quantity",
              {
                "cl_type": "I32",
                "bytes": "e8030000",
                "parsed": 1000
              }
            ]
          ]
        }
      },
      "session": {
        "Transfer": {
          "args": [
            [
              "amount",
              {
                "cl_type": "I32",
                "bytes": "e8030000",
                "parsed": 1000
              }
            ]
          ]
        }
      },
      "approvals": [
        {
        "signer": "01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c",
        "signature": "012dbf03817a51794a8e19e0724884075e6d1fbec326b766ecfa6658b41f81290da85e23b24e88b1c8d9761185c961daee1adab0649912a6477bcd2e69bd91bd08"
        }
      ]
    }
    deploy = Casper::Entity::Deploy.new(json_deploy[:hash], json_deploy[:header], json_deploy[:payment], json_deploy[:session], json_deploy[:approvals])
    # puts Utils::ByteUtils.hex_to_byte_array(serializer.to_bytes(deploy))
    expect(Utils::ByteUtils.byte_array_to_hex(serializer.to_bytes(deploy))).to eql(serialized_deploy)
  end
end