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
    if payment.keys[0] == :ModuleBytes
      result += ""
    elsif payment.keys[0] == :StoredContractByHash
      temp_args = []
      hash = payment[:StoredContractByHash][:hash]
      entry_point = payment[:StoredContractByHash][:entry_point]
      args = payment[:StoredContractByHash][:args]
      stored_contract_by_hash = Casper::Entity::StoredContractByHash.new(hash, entry_point, args)
      
      args.each do |arg|
        name1 = arg[0] # => "quantity"
        clvalue_hash = arg[1] # => {:cl_type=>"I32", :bytes=>"e8030000", :parsed=>1000}
        clvalue = build_cl_value(arg[1])
        # puts clvalue
        temp_args << [Casper::Entity::DeployNamedArgument.new(name1, clvalue)]
      end
      temp = Utils::ByteUtils.byte_array_to_hex(Casper::Entity::StoredContractByHash.new(name, entry_point, temp_args).to_bytes)
      result += temp
      temp = nil
    elsif payment.keys[0] == :StoredContractByName
      temp_args = []
      name = payment[:StoredContractByName][:name]
      entry_point = payment[:StoredContractByName][:entry_point]
      args = payment[:StoredContractByName][:args]

      stored_contract_by_name = Casper::Entity::StoredContractByName.new(name, entry_point, args)
      args.each do |arg|
        name1 = arg[0] # => "quantity"
        clvalue_hash = arg[1] # => {:cl_type=>"I32", :bytes=>"e8030000", :parsed=>1000}
        clvalue = build_cl_value(arg[1])
        temp_args << [Casper::Entity::DeployNamedArgument.new(name1, clvalue)]
      end
      temp = Utils::ByteUtils.byte_array_to_hex(Casper::Entity::StoredContractByName.new(name, entry_point, temp_args).to_bytes)
      result += temp
      temp = nil
    elsif payment.keys[0] == :StoredVersionedContractByHash
      temp_args = []
      hash = payment[:StoredVersionedContractByHash][:name]
      version = payment[:StoredVersionedContractByHash][:version]
      entry_point = payment[:StoredVersionedContractByHash][:entry_point]
      args = payment[:StoredVersionedContractByHash][:args]

      stored_versioned_contract_by_hash = Casper::Entity::StoredVersionedContractByHash.new(hash, version, entry_point, args)
      args.each do |arg|
        name1 = arg[0] 
        clvalue_hash = arg[1] 
        clvalue = build_cl_value(arg[1])
        temp_args << [Casper::Entity::DeployNamedArgument.new(name1, clvalue)]
      end
      temp = Utils::ByteUtils.byte_array_to_hex(Casper::Entity::StoredVersionedContractByHash.new(name, version,entry_point, temp_args).to_bytes)
      result += temp
      temp = nil
    elsif payment.keys[0] == :StoredVersionedContractByName
      temp_args = []
      name = payment[:StoredVersionedContractByName][:name]
      version = payment[:StoredVersionedContractByName][:version]
      entry_point = payment[:StoredVersionedContractByName][:entry_point]
      args = payment[:StoredVersionedContractByName][:args]

      stored_versioned_contract_by_name = Casper::Entity::StoredVersionedContractByName.new(name, version, entry_point, args)
      args.each do |arg|
        name1 = arg[0] 
        clvalue_hash = arg[1] 
        clvalue = build_cl_value(arg[1])
        temp_args << [Casper::Entity::DeployNamedArgument.new(name1, clvalue)]
      end
      temp = Utils::ByteUtils.byte_array_to_hex(Casper::Entity::StoredVersionedContractByName.new(name, version,entry_point, temp_args).to_bytes)
      result += temp
      temp = nil
    elsif payment.keys[0] == :Transfer
      temp_args = []
      args = payment[:Transfer][:args]

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

    if session.keys[0] == :ModuleBytes
      result += ""
    elsif session.keys[0] == :StoredContractByHash
      temp_args = []
      hash = session[:StoredContractByHash][:hash]
      entry_point = session[:StoredContractByHash][:entry_point]
      args = session[:StoredContractByHash][:args]
      stored_contract_by_hash = Casper::Entity::StoredContractByHash.new(hash, entry_point, args)
      
      args.each do |arg|
        name1 = arg[0] # => "quantity"
        clvalue_hash = arg[1] # => {:cl_type=>"I32", :bytes=>"e8030000", :parsed=>1000}
        clvalue = build_cl_value(arg[1])
        # puts clvalue
        temp_args << [Casper::Entity::DeployNamedArgument.new(name1, clvalue)]
      end
      temp = Utils::ByteUtils.byte_array_to_hex(Casper::Entity::StoredContractByHash.new(name, entry_point, temp_args).to_bytes)
      result += temp
      temp = nil
    elsif session.keys[0] == :StoredContractByName
      temp_args = []
      name = session[:StoredContractByName][:name]
      entry_point = session[:StoredContractByName][:entry_point]
      args = session[:StoredContractByName][:args]

      stored_contract_by_name = Casper::Entity::StoredContractByName.new(name, entry_point, args)
      args.each do |arg|
        name1 = arg[0] # => "quantity"
        clvalue_hash = arg[1] # => {:cl_type=>"I32", :bytes=>"e8030000", :parsed=>1000}
        clvalue = build_cl_value(arg[1])
        temp_args << [Casper::Entity::DeployNamedArgument.new(name1, clvalue)]
      end
      temp = Utils::ByteUtils.byte_array_to_hex(Casper::Entity::StoredContractByName.new(name, entry_point, temp_args).to_bytes)
      result += temp
      temp = nil
    elsif session.keys[0] == :StoredVersionedContractByHash
      temp_args = []
      hash = session[:StoredVersionedContractByHash][:name]
      version = session[:StoredVersionedContractByHash][:version]
      entry_point = session[:StoredVersionedContractByHash][:entry_point]
      args = session[:StoredVersionedContractByHash][:args]

      stored_versioned_contract_by_hash = Casper::Entity::StoredVersionedContractByHash.new(hash, version, entry_point, args)
      args.each do |arg|
        name1 = arg[0] 
        clvalue_hash = arg[1] 
        clvalue = build_cl_value(arg[1])
        temp_args << [Casper::Entity::DeployNamedArgument.new(name1, clvalue)]
      end
      temp = Utils::ByteUtils.byte_array_to_hex(Casper::Entity::StoredVersionedContractByHash.new(name, version,entry_point, temp_args).to_bytes)
      result += temp
      temp = nil
    elsif session.keys[0] == :StoredVersionedContractByName
      temp_args = []
      name = session[:StoredVersionedContractByName][:name]
      version = session[:StoredVersionedContractByName][:version]
      entry_point = session[:StoredVersionedContractByName][:entry_point]
      args = session[:StoredVersionedContractByName][:args]

      stored_versioned_contract_by_name = Casper::Entity::StoredVersionedContractByName.new(name, version, entry_point, args)
      args.each do |arg|
        name1 = arg[0] 
        clvalue_hash = arg[1] 
        clvalue = build_cl_value(arg[1])
        temp_args << [Casper::Entity::DeployNamedArgument.new(name1, clvalue)]
      end
      temp = Utils::ByteUtils.byte_array_to_hex(Casper::Entity::StoredVersionedContractByName.new(name, version,entry_point, temp_args).to_bytes)
      result += temp
      temp = nil

    elsif session.keys[0] == :Transfer
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

  def build_cl_value(h = {})
    cl_type = h[:cl_type]
    bytes = h[:bytes]
    parsed = h[:parsed]
    if cl_type == "Bool"
      CLValueBytesParsers::CLBoolBytesParser.from_bytes([bytes])
    elsif cl_type == "I32"
      value = Utils::ByteUtils.hex_to_integer(bytes)
      CLi32.new(value)
    elsif cl_type == "I64"
      value = Utils::ByteUtils.hex_to_i64_value(bytes)
      CLi64.new(value)
    elsif cl_type == "U8"
      value = Utils::ByteUtils.hex_to_u8_value(bytes)
      CLu8.new(value)
    elsif cl_type == "U32"
      value = Utils::ByteUtils.hex_to_u32_value(bytes)
      CLu32.new(value)
    elsif cl_type == "U64"
      value = Utils::ByteUtils.hex_to_u64_value(bytes)
      CLu32.new(value)
    elsif cl_type == "Unit"
      # value = CLValueBytesParsers::CLUnitBytesParser.from_bytes(bytes)
      if bytes == ""
        value = nil
        CLUnit.new(value)
      end
    elsif cl_type == "String"
      value = CLValueBytesParsers::CLStringBytesParser.from_bytes(bytes)
      CLString.new(value)
    elsif cl_type == "URef"
      value = Utils::ByteUtils.hex_to_byte_array(bytes)
      CLValueBytesParsers::CLURefBytesParser.from_bytes(value)
    elsif cl_type == "PublicKey"
      CLPublicKey.from_hex(bytes)
    end


  end
end