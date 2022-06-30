require_relative '../entity/deploy_header.rb'
require_relative '../serialization/cl_value_bytes_parsers.rb'
require_relative '../utils/time_utils.rb'
require_relative '../utils/byte_utils.rb'


class DeployHeaderSerializer 

  # @param [DeployerHeader] header
  # @return [String] serialized_header
  def to_bytes(deploy_header)
    @serialized_header = ""

    @account = deploy_header.get_account
    @serialized_account = @account
    @serialized_header << @serialized_account

    @timestamp = deploy_header.get_timestamp
    timestamp_ms = Utils::TimeUtils.to_epoc_ms(@timestamp)
    @serialized_timestamp = Utils::ByteUtils.to_u64(timestamp_ms)
    @serialized_header << @serialized_timestamp

    @ttl = deploy_header.get_ttl
    ttl_ms = Utils::TimeUtils.ttl_to_milliseconds(@ttl)
    @serialized_ttl = Utils::ByteUtils.to_u64(ttl_ms)
    @serialized_header << @serialized_ttl
    
    @gas_price = deploy_header.get_gas_price
    @serialized_gas_price = Utils::ByteUtils.to_u64(@gas_price)
    @serialized_header << @serialized_gas_price

    @body_hash = deploy_header.get_body_hash
    @serialized_body_hash = @body_hash
    @serialized_header << @serialized_body_hash

    @dependencies = deploy_header.get_dependencies
    @serialized_dependencies = Utils::ByteUtils.to_u32(@dependencies.size) + @dependencies.join("")
    @serialized_header << @serialized_dependencies

    # @chain_name = CLString.new(deploy_header.get_chain_name)
    # @serialized_chain_name = @chain_name.to_bytes(deploy_header.get_chain_name)
    @chain_name = deploy_header.get_chain_name
    @serialized_chain_name = CLValueBytesParsers::CLStringBytesParser.to_bytes(@chain_name)

    @serialized_header << @serialized_chain_name
    @serialized_header
  end
end

