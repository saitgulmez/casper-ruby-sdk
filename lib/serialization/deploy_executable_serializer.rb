require_relative '../entity/deploy_executable.rb'

# Byte serializer for DeployExecutable object
class DeployExecutableSerializer

  def initialize 
    @deploy_executable = Casper::Entity::DeployExecutable.new
  end

  # @param [DeployExecutable] deploy_executable
  def to_bytes(deploy_executable)
    if deploy_executable.module_bytes?
      deploy_executable.get_module_bytes.to_bytes
    elsif deploy_executable.stored_contract_by_hash?
      deploy_executable.stored_contract_by_hash.to_bytes
    elsif deploy_executable.stored_contract_by_name?
      deploy_executable.stored_contract_by_name.to_bytes
    elsif deploy_executable.stored_versioned_contract_by_hash?
      deploy_executable.stored_versioned_contract_by_hash.to_bytes
    elsif deploy_executable.stored_versioned_contract_by_name?
      deploy_executable.stored_versioned_contract_by_name.to_bytes
    elsif deploy_executable.transfer?
      deploy_executable.transfer.to_bytes
    end
  end
  
end
