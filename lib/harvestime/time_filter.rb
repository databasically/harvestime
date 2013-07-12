require 'harvested'

module Harvestime
  class TimeFilter
    def initialize(client)
      @client = client
    end
    def scale_entry(time_entry, modifier)
      time_entry.hours = time_entry.hours * modifier
      @client.time.update(time_entry)
      time_entry.hours
    end
    # Current date only
    def all_times
      @client.time.all
    end           
    def all_times_in_date(time)
      @client.time.all(time)
    end                                                                          
    def move_entry_from(other_account, entry)
      create_entry(build_entry_from_existing(entry))
      other_account.time.delete(entry)
      :success
    end
    def copy_entry_from(other_account, entry)
      create_entry(build_entry_from_existing(entry))
    end
    def copy_date_range(other_account, start_date, end_date)
      date_range = (Date.parse(start_date.to_s)..Date.parse(end_date.to_s))
        .map { |day| day }      
      date_range.each do |date|
        other_account.time.all(date).each do |entry|
          copy_entry_from(other_account, entry)
        end
      end
    end
    def delete_date_range(start_date, end_date)
      date_range = (Date.parse(start_date.to_s)..Date.parse(end_date.to_s))
        .map { |day| day }
      date_range.each do |date|
        all_times_in_date(date).each do |entry|
          delete_entry(entry)
        end
      end
    end
    # Ensure client exists.
    def build_entry(args = {})
     Harvest::TimeEntry.new(
     {     notes: '',
           hours: '0',
      project_id:  0,
         task_id:  0,
        spent_at:  Date.today.strftime('%a, %e %b %Y')
     }.merge(args)
     )
    end
    def build_entry_from_existing(entry)
      Harvest::TimeEntry.new(
             notes: entry.notes,
             hours: entry.hours,
        project_id: entry.project_id,
           task_id: entry.task_id,
          spent_at: entry.spent_at
       )
    end
    def clear_daily_entries
      @client.time.all.each do |entry|
        delete_entry(entry)
      end
      :success
    end
    def delete_entry(entry)
      @client.time.delete(entry)
      :success
    end
    def create_entry (entry) 
      @client.time.create(entry)
      :success
    end
  end
end