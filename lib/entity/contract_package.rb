module Casper
  module Entity

    # Contract definition, metadata and security container.
    class ContractPackage 
      
      # @param [CLURef] access_key
      # @param [ContractVersion] versions
      # @param [DisabledVersion] disabled_versions
      # @param [Group] groups
      def initialize(access_key, versions, disabled_versions, groups)
        @access_key = access_key
        @versions = versions
        @disabled_versions = disabled_versions
        @groups = groups
      end

      # @return [CLURef] access_key
      def get_access_key
        @access_key
      end

      # @return [ContractVersion] versions
      def get_versions
        @versions
      end

      # @return [DisabledVersion] versions
      def get_disabled_versions
        @disabled_versions
      end

      # @return [Group] groups
      def get_groups
        @groups
      end


    end
  end
end