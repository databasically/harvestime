require 'spec_helper'
require 'harvested'
require 'harvestime'
require File.expand_path('lib/harvestime/invoice_filter')
include Harvestime
describe 'Harvestime::InvoiceFilter' do
  let(:client) { Harvest.hardy_client( 'sandboxbasically',
                                       'nick.s.fausnight@gmail.com',
                                       'sandbox' ) }
  let(:filter) { Harvestime::InvoiceFilter.new( client ) }
  it "should build an InvoiceCollection" do
    expect( filter.all_invoices ).to be_a_kind_of( Array )
   # expect( filter.all_invoices.size ).to eq( 3 )
  end
  
  it "returns all outstanding invoices" do
    expect( filter.outstanding_invoices ).to be_a_kind_of( Array )
    # expect( filter.outstanding_invoices.size).to eq( 2 ) 
  end
  
  it "returns a collection of paid invoices" do
    expect( filter.paid_invoices ).to be_a_kind_of( Array )
    # expect( filter.paid_invoices.size ).to eq( 1 )
  end
  
  it "should get all invoices by a client" do
    expect( filter.all_by_client_id( 1761076 ) ).to be_a_kind_of( Array )
    # expect( filter.all_by_client_id( 1761076 ).size ).to eq( 2 )
  end
  it "should get outstanding invoices by a client" do
    expect( filter.outstanding_by_client_id( 1761076 ) ).to be_a_kind_of( Array )
    # expect( filter.outstanding_by_client_id( 1761076 ).size ).to eq( 1 )
  end
end


