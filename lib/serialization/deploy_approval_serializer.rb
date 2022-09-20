require_relative '../entity/deploy_approval.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'
require_relative '../utils/time_utils.rb'
require_relative '../utils/byte_utils.rb'

# Byte serializer for DeployApproval object
class DeployApprovalSerializer
  def to_bytes(deploy_approval)
    @approval_serializer = ""
    @signer = deploy_approval.get_signer
    @approval_serializer << @signer
    
    @signature = deploy_approval.get_signature
    @approval_serializer << @signature
  end
end