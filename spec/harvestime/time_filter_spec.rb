require 'spec_helper'
require 'harvested'

require File.expand_path( 'lib/harvestime/time_filter.rb' )
describe 'Harvestime::TimeFilter' do
  let(:client) { Harvest.hardy_client( 'sandboxbasically',
                                       'nick.s.fausnight@gmail.com',
                                       'sandbox' ) }
  let(:time_filter) { Harvestime::TimeFilter.new( client ) }
  
  it 'should scale hours down based on a given modifier', focus: :true do
    modifier = 0.8
    time = client.time.all(Time.parse('6/21'))[0]
    hours = time.hours
    expect( time_filter.scale_entry( time, modifier ) )
      .to eq( hours * modifier )
  end

  it 'should transfer hours from another account' do
    second_account = Harvest.hardy_client( 'sandboxbasically2',
                                           'sandbox2@nsf.33mail.com',
                                           'sandbox')
    moving_hours = 12
    expect( time_filter.move_hours_from_account( moving_hours, second_account ))
      .to eq( check_moved_hours )
  end

end