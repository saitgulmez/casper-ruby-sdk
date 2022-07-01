require_relative '../lib/serialization/deploy_approval_serializer.rb'


RSpec.describe DeployApprovalSerializer do

  it "should serialize DeployAproval" do
    approvals = [
      {
          "signer": "01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c",
          "signature": "012dbf03817a51794a8e19e0724884075e6d1fbec326b766ecfa6658b41f81290da85e23b24e88b1c8d9761185c961daee1adab0649912a6477bcd2e69bd91bd08"
      }
    ]
    expected_serialized_deploy_approvals = "01d9bf2148748a85c89da5aad8ee0b0fc2d105fd39d41a4c796536354f0ae2900c012dbf03817a51794a8e19e0724884075e6d1fbec326b766ecfa6658b41f81290da85e23b24e88b1c8d9761185c961daee1adab0649912a6477bcd2e69bd91bd08"
    
    for item in approvals do
      result = ""  
      approval = Casper::Entity::DeployApproval.new(item)

      deploy_approval_serializer = DeployApprovalSerializer.new
      approval_serializer = deploy_approval_serializer.to_bytes(approval)
      result << approval_serializer
    end
      expect(result).to eql(expected_serialized_deploy_approvals)
  end
end

