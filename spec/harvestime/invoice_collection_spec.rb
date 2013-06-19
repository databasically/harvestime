require 'spec_helper'
require 'harvested'
require File.expand_path('lib/harvestime/invoice_collection')

describe 'Harvestime::InvoiceCollection' do
  let( :invoices ) { Harvestime::InvoiceCollection.new}
  let( :invoice  ) { Harvest::Invoice.new( :line_items => "kind,description,quantity,unit_price,amount,taxed,taxed2,project_id\nService,Abc,200,12.00,2400.0,false,false,100\nService,def,1.00,20.00,20.0,false,false,101\n" ) }
 
  it "should recieve an invoice and add it to its collection" do
    expect( invoices.add( invoice )).to eq( [invoice] )
  end
  
  it "should give its collection" do
    expect( invoices.retrieve ).to be_a_kind_of( Array )
  end
  
  it "should ignore duplicate entries" do
    expected_collection = Harvestime::InvoiceCollection.new( invoice )
    
    3.times { invoices.add( invoice ) }
    
    expect( invoices.retrieve ).to eq( expected_collection.retrieve )
  end
end

# InvoiceCollection.retrieve => [Invoice, Invoice, Invoice, Invoice, Invoice]