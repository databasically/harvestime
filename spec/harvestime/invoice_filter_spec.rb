require 'spec_helper'
require 'harvested'
require 'harvestime'
require File.expand_path('lib/harvestime/invoice_filter')
include Harvestime
describe 'Harvestime::InvoiceFilter' do
  build_harvest_client('sandboxbasically',
                                  'nick.s.fausnight@gmail.com',
                                  'sandbox') 
  let(:filter) { Harvestime::InvoiceFilter.new }
  it "should build an InvoiceCollection" do
    expect( filter.all_invoices ).to be_a_kind_of( Harvestime::InvoiceCollection )
    expect( filter.all_invoices.retrieve.size ).to eq( 3 )
  end
  
  it "returns all outstanding invoices" do
    expect( filter.outstanding_invoices ).to be_a_kind_of( Harvestime::InvoiceCollection )
    expect( filter.outstanding_invoices.retrieve.size).to eq( 2 ) 
  end
  
  it "returns a collection of paid invoices" do
    expect( filter.paid_invoices ).to be_a_kind_of( Harvestime::InvoiceCollection )
    expect( filter.paid_invoices.retrieve.size ).to eq( 1 )
  end
  
end