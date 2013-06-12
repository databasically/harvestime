require 'spec_helper'

describe 'Log into Harvest' do
  it 'should be successful' do
    expect(harvest_client).to be_present
  end
end