module Casper
  module Entity
    # Data structure summarizing auction contract data.
    class AuctionState
      # @param [String] state_root_hash
      # @param [Integer] block_height
      # @param [Array<Hash>] era_validators
      # @option era_validators [Integer] :era_id
      # @option era_validators [Array<Hash>] :validator_weights
      # @param [Array<Hash>] bids
      def initialize(state_root_hash, block_height, era_validators, bids)
        @state_root_hash = state_root_hash
        @block_height = block_height

        @era_validators = []
        era_validators.each do |era_validator|
          @validators_weights = []
          era_validator[:validator_weights].each do |validator_weight|
            @validators_weights << Casper::Entity::ValidatorWeight.new(validator_weight[:public_key], validator_weight[:weight])
          end
          @era_validators << Casper::Entity::EraValidator.new(era_validator[:era_id], @validators_weights)
          @validators_weights = []
          # puts Casper::Entity::EraValidator.new(era_validator[:era_id], @validators_weights).get_era_id
          # puts Casper::Entity::EraValidator.new(era_validator[:era_id], @validators_weights).get_validator_weights
        end

        # @era_validators.each do |era_validator| 
        #   puts era_validator.get_validator_weights[0].get_era_id
        #   puts era_validator.get_validator_weights[0].get_weight
        # end

        @bids = bids
        @bids_list = []
        
        bids.each do |bid|
          bid_info = bid[:bid]
          @delegators_list = []
          delegators = bid_info[:delegators]

          delegators.each do |delegator| 
            @delegators_list << Casper::Entity::Delegator.new(
              delegator[:public_key], 
              delegator[:staked_amount], 
              delegator[:bonding_purse], 
              delegator[:delegatee]
              )
            # puts delegator
            # puts delegator[:public_key]
          end
          
          bid_info = Casper::Entity::BidInfo.new(
            bid_info[:bonding_purse], 
            bid_info[:staked_amount], 
            bid_info[:delegation_rate],
            bid_info[:vesting_schedule],
            # bid_info[:delegators],
            @delegators_list,
            bid_info[:inactive]
            )
          @bids_list << Casper::Entity::Bid.new(bid[:public_key], bid_info)
        end
      end

      # @return [String] state root hash as a String
      def get_state_root_hash
        @state_root_hash
      end

      # @return [Integer] block height as an Integer 
      def get_block_height
        @block_height
      end

      # @return [Array<EraValidator>] array of EraValidator
      def get_era_validators
        @era_validators
      end

      # @return [Array<Bid>] array of Bid
      def get_bids
        @bids_list
      end
    end
  end
end
