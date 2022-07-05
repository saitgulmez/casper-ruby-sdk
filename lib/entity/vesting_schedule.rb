module Casper
  module Entity

    # Vesting schedule for a genesis validator.
    class VestingSchedule

      def initialize(vesting_schedule = {})
        @initial_release_timestamp_millis = vesting_schedule[:initial_release_timestamp_millis]
        @locked_amounts = vesting_schedule[:locked_amounts]
      end

      def get_initial_release_timestamp_millis
        @initial_release_timestamp_millis
      end

      def get_locked_amounts
        @locked_amounts
      end

    end
  end
end