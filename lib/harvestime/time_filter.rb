require 'harvested'

module Harvestime
  class TimeFilter

    def initialize( client )
      @client = client
    end

    def scale_entry( time_entry, modifier )
      time_entry.hours = time_entry.hours * modifier
      @client.time.update( time_entry )
      time_entry.hours
    end
    # Current date only
    def all_times
      @client.time.all
    end

    def all_times_in_date( time )
      @client.time.all( date = time )
    end

    def build_entry( args = {} )
      args[:notes]      ||= ''
      args[:hours]      ||= 0
      args[:project_id] ||= 0
      args[:task_id]    ||= 0
      args[:spent_at]   ||= Time.now

      entry = {
        :request      => {
          :notes      => args[:notes],
          :hours      => args[:hours],
          :project_id => args[:project_id],
          :task_id    => args[:task_id],
          :spent_at   => args[:spent_at]
        }
      }
    end

    def create_entry (entry) 
      @client.time.create(entry)
    end
  end
end