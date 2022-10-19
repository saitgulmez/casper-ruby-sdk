### Serialization
Casper provides a custom implementation to serialize data structures used by the Casper node to their byte representation.
More information on this custom implementation can be found [here](https://caspernetwork.readthedocs.io/en/latest/implementation/serialization-standard.html).

### Examples

Note: In the following examples, bytes variable is a hex representation of bytes.

#### CLType Serialization

```ruby
serializer = CLValueSerializer.new
```
- CLString

```ruby
# CLString value serialization can be done in three different ways
clvalue = CLString.new("Hello, World!")
str = clvalue.get_value
# => "Hello, World!"
bytes = CLString.to_bytes(clvalue)
expect(bytes).to eql("0d00000048656c6c6f2c20576f726c6421")

bytes = CLValueBytesParsers::CLStringBytesParser.to_bytes(str)
expect(bytes).to eql("0d00000048656c6c6f2c20576f726c6421")

bytes = clvalue.to_bytes(str)
expect(bytes).to eql("0d00000048656c6c6f2c20576f726c6421")

```

- CLu32

```ruby
MIN_U32 = 0
clvalue = CLu32.new(MIN_U32)
bytes = serializer.to_bytes(clvalue)
expect(bytes).to eql("040000000000000004")

clvalue = CLu32.new(1024)
bytes = serializer.to_bytes(clvalue)
expect(bytes).to eql("040000000004000004")

MAX_U32 = 2.pow(32) - 1
clvalue = CLu32.new(MAX_U32)
bytes = serializer.to_bytes(clvalue)
expect(bytes).to eql("04000000ffffffff04")

```

- CLOption

```ruby
bytes = serializer.to_bytes(CLOption.new(CLu32.new(MIN_U32)))
expect(bytes).to eql("0500000001000000000d04")

```

#### CLValue Serialization

- CLValue with CLu512 CLType

```ruby
clvalue = CLu512.new(2500000000)
bytes = serializer.to_bytes(clvalue)
expect(bytes).to eql("050000000400f9029508")

```

- CLValue with CLTuple2  CLType

```ruby
clvalue = CLTuple2.new([CLu32.new(127), CLString.new("ABCDE")])
bytes = serializer.to_bytes(clvalue)
expect(bytes).to eql("0d0000007f00000005000000414243444513040a")

```

### Serialization of DeployExecutable objects

- ModuleBytes 

```ruby
args = []
arg1 = Casper::Entity::DeployNamedArgument.new("amount", CLu512.new(2500000000))
args << [arg1]
module_bytes = Casper::Entity::ModuleBytes.new("", args)
expect(Utils::ByteUtils.byte_array_to_hex(module_bytes.to_bytes)).to eql("00000000000100000006000000616d6f756e74050000000400f9029508")
```

- StoredContractByHash

```ruby
args = []
arg1 = Casper::Entity::DeployNamedArgument.new("quantity", CLi32.new(1000))
args << [arg1]
stored_contract_by_hash = Casper::Entity::StoredContractByName.new("c4c411864f7b717c27839e56f6f1ebe5da3f35ec0043f437324325d65a22afa4", "pclphXwfYmCmdITj8hnh", args)
expect(Utils::ByteUtils.byte_array_to_hex(stored_contract_by_hash.to_bytes)).to eql("01c4c411864f7b717c27839e56f6f1ebe5da3f35ec0043f437324325d65a22afa41400000070636c7068587766596d436d6449546a38686e6801000000080000007175616e7469747904000000e803000001")
```

- StoredContractByName

```ruby
args = []
arg1 = Casper::Entity::DeployNamedArgument.new("quantity", CLi32.new(1000))
args << [arg1]
stored_contract_by_name = Casper::Entity::StoredContractByName.new("casper-example", "example-entry-point", args)
expect(Utils::ByteUtils.byte_array_to_hex(stored_contract_by_name.to_bytes)).to eql("020e0000006361737065722d6578616d706c65130000006578616d706c652d656e7472792d706f696e7401000000080000007175616e7469747904000000e803000001")

```

- StoredVersionedContractByHash 

```ruby
args = []
arg1 = Casper::Entity::DeployNamedArgument.new("test", CLString.new("Hello, World!"))
args << [arg1]
stored_versioned_contract_by_hash = Casper::Entity::StoredVersionedContractByHash.new("b348fdd0d0b3f66468687df93141b5924f6bb957d5893c08b60d5a78d0b9a423", nil, "PsLz5c7JsqT8BK8ll0kF", args)
expect(Utils::ByteUtils.byte_array_to_hex(stored_versioned_contract_by_hash.to_bytes)).to eql("03b348fdd0d0b3f66468687df93141b5924f6bb957d5893c08b60d5a78d0b9a423001400000050734c7a3563374a73715438424b386c6c306b46010000000400000074657374110000000d00000048656c6c6f2c20576f726c64210a")

```

- DeployTransfer   

```ruby
args = []
arg1 = Casper::Entity::DeployNamedArgument.new("amount", CLi32.new(1000))
args << [arg1]
transfer = Casper::Entity::DeployExecutableTransfer.new(args)
expect(Utils::ByteUtils.byte_array_to_hex(transfer.to_bytes)).to eql("050100000006000000616d6f756e7404000000e803000001")

```

- StoredVersionedContractByName    

```ruby
args = []
arg1 = Casper::Entity::DeployNamedArgument.new("test", CLString.new("Hello, World!"))
args << [arg1]
stored_versioned_contract_by_name = Casper::Entity::StoredVersionedContractByName.new("test-contract", nil, "PsLz5c7JsqT8BK8ll0kF", args)
expect(Utils::ByteUtils.byte_array_to_hex(stored_versioned_contract_by_name.to_bytes)).to eql("040d000000746573742d636f6e7472616374001400000050734c7a3563374a73715438424b386c6c306b46010000000400000074657374110000000d00000048656c6c6f2c20576f726c64210a")

```

### Serialization of Deploy  objects

```ruby
serializer = DeploySerializer.new
serialized_deploy = "01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900ca856a4d37501000080ee36000000000001000000000000004811966d37fe5674a8af4001884ea0d9042d1c06668da0c963769c3a01ebd08f0100000001010101010101010101010101010101010101010101010101010101010101010e0000006361737065722d6578616d706c6501da3c604f71e0e7df83ff1ab4ef15bb04de64ca02e3d2b78de6950e8b5ee187020e0000006361737065722d6578616d706c65130000006578616d706c652d656e7472792d706f696e7401000000080000007175616e7469747904000000e803000001050100000006000000616d6f756e7404000000e8030000010100000001d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c012dbf03817a51794a8e19e0724884075e6d1fbec326b766ecfa6658b41f81290da85e23b24e88b1c8d9761185c961daee1adab0649912a6477bcd2e69bd91bd08"
json_deploy = '{
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
}'
h_deploy = JSON.parse(json_deploy)
h_deploy.deep_symbolize_keys!
deploy = Casper::Entity::Deploy.new(h_deploy[:hash], h_deploy[:header], h_deploy[:payment], h_deploy[:session], h_deploy[:approvals])
expect(Utils::ByteUtils.byte_array_to_hex(serializer.to_bytes(deploy))).to eql(serialized_deploy)

```

