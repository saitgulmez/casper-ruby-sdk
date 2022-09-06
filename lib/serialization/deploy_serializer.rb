require_relative './deploy_header_serializer'
require_relative './deploy_approval_serializer'
require_relative './deploy_executable_serializer'
require_relative './deploy_named_arg_serializer'

class DeploySerializer

  def to_bytes(deploy)
    result = "" 
    deploy_header = Casper::Entity::DeployHeader.new(deploy.get_header)
    result += DeployHeaderSerializer.new().to_bytes(deploy_header)
    
    deploy_hash = Casper::Entity::DeployHash.new(deploy.get_hash)
    result += deploy_hash.get_hash
        
    # payment = deploy.get_payment
    # puts payment
    # session = deploy.get_session
    # puts session

    approvals =  deploy.get_approvals
    num_of_approvals = approvals.size
    deploy_approval_serializer = DeployApprovalSerializer.new
    result += Utils::ByteUtils.to_u32(num_of_approvals)
    for approval in approvals
      deploy_approval = Casper::Entity::DeployApproval.new(approval)
      # puts deploy_approval
      result += deploy_approval_serializer.to_bytes(deploy_approval)
    end
    result
  end
end