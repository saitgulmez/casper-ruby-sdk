module Casper
  module Entity
    
    # @note The minimum weight thresholds that have to be met when executing an action of a certain type. 
    class ActionThresholds

      # @param [Integer] deployment, threshold required to perform deployment actions.
      # @param [Integer] key_management, threshold required to perform key management actions.
      def initialize(deployment, key_management)
        @deployment = deployment
        @key_management = key_management
      end

      # @return [Integer] deployment
      def get_deployment
        @deployment
      end

      # @return [Integer] key_management
      def get_key_management
        @key_management
      end
    end
  end
end