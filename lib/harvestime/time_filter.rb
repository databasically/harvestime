require 'harvested'

module Harvestime
  class TimeFilter

    def initialize( client )
      @client = client
    end

    def scale_time_entry( time_entry, modifier )
      time_entry.hours = time_entry.hours * modifier
      @client.time.update( time_entry )
      time_entry.hours
    end
# Current date only
    def all_times
      client.time.all
    end

    def all_times_in_date( time )
      client.time.all( date = time )
    end
  end
end