require_relative '../lib/serialization/deploy_header_serializer.rb'

RSpec.describe DeployHeaderSerializer do  
  it "should serialize DeployHeader" do 
    header =  {
        "account": "01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c",
        "timestamp": "2020-11-17T00:39:24.072Z",
        "ttl": "1h",
        "gas_price": 1,
        "body_hash": "4811966d37fe5674a8af4001884ea0d9042d1c06668da0c963769c3a01ebd08f",
        "dependencies": ["0101010101010101010101010101010101010101010101010101010101010101"],
        "chain_name": "casper-example"
    }
    
    expected_serialized_deploy_header = "01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900ca856a4d37501000080ee36000000000001000000000000004811966d37fe5674a8af4001884ea0d9042d1c06668da0c963769c3a01ebd08f0100000001010101010101010101010101010101010101010101010101010101010101010e0000006361737065722d6578616d706c65"

    deploy_header = Casper::Entity::DeployHeader.new(header)
    header_serializer = DeployHeaderSerializer.new
    expect(header_serializer.to_bytes(deploy_header)).to eql(expected_serialized_deploy_header)
  end
end