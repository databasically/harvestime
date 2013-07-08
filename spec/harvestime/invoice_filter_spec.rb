require 'spec_helper'
require 'harvested'
require 'harvestime'
require File.expand_path('lib/harvestime/invoice_filter')
describe 'Harvestime::InvoiceFilter' do
  let(:client) { Harvest.hardy_client('subdomain',
                                       'username@email.com',
                                       'password') }
  let(:filter) { Harvestime::InvoiceFilter.new(client) }
  it "should build an InvoiceCollection" do
    expect(filter.all_invoices).to be_a_kind_of(Array)
   # expect(filter.all_invoices.size).to eq(3)
  end
  
  it "returns all outstanding invoices" do
    expect(filter.all_with_status(:unpaid)).to be_a_kind_of(Array)
    # expect(filter.outstanding_invoices.size).to eq(2) 
  end
  
  it "returns a collection of paid invoices" do
    expect(filter.all_with_status(:paid)).to be_a_kind_of(Array)
    # expect(filter.paid_invoices.size).to eq(1)
  end
  
  it "should get all invoices by a client" do
    expect(filter.all_by_client_id(1761076)).to be_a_kind_of(Array)
    # expect(filter.all_by_client_id(1761076).size).to eq(2)
  end
  it "should get outstanding invoices by a client" do
    expect(filter.all_with_status_and_client(:unpaid, 1761076))
      .to be_a_kind_of(Array)
    # expect(filter.outstanding_by_client_id(1761076).size).to eq(1)
  end
end