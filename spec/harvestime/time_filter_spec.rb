require 'spec_helper'
require 'harvested'

require File.expand_path('lib/harvestime/time_filter.rb')
describe 'Harvestime::TimeFilter' do
  # Interface one
  let(:client) {Harvest.hardy_client('sandboxbasically',
                                     'nick.s.fausnight@gmail.com',
                                     'sandbox')}
  # Interface two
  let(:client2) {Harvest.hardy_client('sandboxbasically',
                                      'employee@nsf.33mail.com',
                                      'q4KHl80I')}
  # Get rid of this
  let(:time_filter) { Harvestime::TimeFilter.new(client) }
  
  it 'should scale hours down based on a given modifier' do
    modifier = 0.8
    time = client.time.all(Time.parse('6/21'))[0]
    hours = time.hours
    expect(time_filter.scale_entry(time, modifier))
      .to eq(hours * modifier)
  end

  it 'should transfer time entry from another account' do
    
    entry = client2.time.all[0]
    expect(time_filter.move_entry_from(client2, entry))
      .to eq(:success)
  end

  it 'should create a time entry' do
    notes = 'Sample note'
    hours = 12
    project_id = client.projects.all[0].id
    task_id = client.tasks.all[0].id
    spent_at = Time.now

    entry = time_filter.build_entry(notes: notes,
                                    hours: hours,
                                    project_id: project_id,
                                    task_id: task_id,
                                    spent_at: spent_at)
    expect(time_filter.create_entry(entry)).to eq(:success)
  end
end