require_relative './deploy_header_serializer'
require_relative './deploy_approval_serializer'
require_relative './deploy_executable_serializer'
require_relative './deploy_named_arg_serializer'
require_relative '../utils/byte_utils.rb'

class DeploySerializer

  def to_bytes(deploy)
    result = "" 
    deploy_header = Casper::Entity::DeployHeader.new(deploy.get_header)
    result += DeployHeaderSerializer.new().to_bytes(deploy_header)
    
    deploy_hash = Casper::Entity::DeployHash.new(deploy.get_hash)
    result += deploy_hash.get_hash
        
    payment = deploy.get_payment
    session = deploy.get_session
    key1 = payment.keys[0]
    # args = []
    if payment.keys[0] == :StoredContractByName
      temp_args = []
      name = payment[:StoredContractByName][:name]
      entry_point = payment[:StoredContractByName][:entry_point]
      args = payment[:StoredContractByName][:args]
      num_of_args = args.size

      stored_contract_by_name = Casper::Entity::StoredContractByName.new(name, entry_point, args)
      args[0]
      args.each do |arg|
        name1 = arg[0] # => "quantity"
        clvalue_hash = arg[1] # => {:cl_type=>"I32", :bytes=>"e8030000", :parsed=>1000}
        clvalue = build_cl_value(arg[1])
        # puts clvalue
        temp_args << [Casper::Entity::DeployNamedArgument.new(name1, clvalue)]
      end
      temp = Utils::ByteUtils.byte_array_to_hex(Casper::Entity::StoredContractByName.new(name, entry_point, temp_args).to_bytes)
      result += temp
      temp = nil
    end

    if session.keys[0] == :Transfer
      temp_args = []
      args = session[:Transfer][:args]

      transfer = Casper::Entity::DeployExecutableTransfer.new(args)
      args.each do |arg|
        name1 = arg[0] # => "amount"
        clvalue_hash = arg[1] # => {:cl_type=>"I32", :bytes=>"e8030000", :parsed=>1000}
        clvalue = build_cl_value(arg[1])
        # puts clvalue
        temp_args << [Casper::Entity::DeployNamedArgument.new(name1, clvalue)]
      end
      temp = Utils::ByteUtils.byte_array_to_hex(Casper::Entity::DeployExecutableTransfer.new(temp_args).to_bytes)
      result += temp
      temp = nil
    end

    approvals =  deploy.get_approvals
    num_of_approvals = approvals.size
    deploy_approval_serializer = DeployApprovalSerializer.new
    result += Utils::ByteUtils.to_u32(num_of_approvals)
    for approval in approvals
      deploy_approval = Casper::Entity::DeployApproval.new(approval)
      result += deploy_approval_serializer.to_bytes(deploy_approval)
    end
    result
  end

  def build_cl_value_from_hash(h = {})
    cl_type = h[:cl_type]
    bytes = h[:bytes]
    parsed = h[:parsed]

    if cl_type == "I32"
      value = Utils::ByteUtils.hex_to_integer(bytes)
      CLi32.new(value)
    end

  end
end