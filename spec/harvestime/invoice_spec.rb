require 'spec_helper'
require File.expand_path('lib/harvestime/invoice')

describe "Harvestime::" do
  describe "Invoice" do
    let( :invoice ) { Harvestime::Invoice.new }
    
    it "should instantiate from xml" do
      xml_document = File.open( "spec/support/invoice_api_call.xml" )
      expect( invoice.retrieve( "spec/support/invoice_api_call.xml" ) ).to be( :success )
    end
    
    context "date parsing" do      
      it "should handle date format" do
        string = "2008-04-09T12:07:56Z"
        expectation = Date.new(2008, 4, 9)
        expect(invoice.parse_date(string)).to eq(expectation)        
      end
      
      it "should handle blank date" do
        string = ""
        expectation = Time.new("").to_date
        expect(invoice.parse_date(string)).to eq(expectation)
      end
    end
    
    context "attribute fields" do 
      before(:each) do
        xml_document = File.open( "spec/support/invoice_api_call.xml" )
        invoice.retrieve( "spec/support/invoice_api_call.xml" )
      end
      
      it "should have an id" do
        expect( invoice.id ).to be_a_kind_of( Integer )
        expect( invoice.id ).to eq( 1234567 )
      end
      
      it "should have an amount" do
        expect( invoice.amount ).to be_a_kind_of( Float )
        expect( invoice.amount ).to eq( 1155.0)
      end
      
      it "should have the due amount" do
        expect( invoice.due_amount ).to be_a_kind_of( Float )
        expect( invoice.due_amount ).to eq( 0.0 )
      end
      
      it "should have the due at date" do
        expect( invoice.due_date ).to be_a_kind_of( Date )
        expect( invoice.due_date ).to eq( Date.parse( '2008-02-06' ) )
      end
            
      it "should have the human form of the due date" do
        expect( invoice.human_due_date ).to be_a_kind_of( String )
        expect( invoice.human_due_date ).to eq( 'due upon receipt' )
      end
      
      it "should have the period end date" do
        expect( invoice.period_end ).to be_a_kind_of( Date )
      end
      
      it "should have the period start date" do
        expect( invoice.period_start ).to be_a_kind_of( Date )
      end
      
      it "should have the client's id" do
        expect( invoice.client_id ).to be_a_kind_of( Integer )
        expect( invoice.client_id ).to eq( 46066 )
      end
      
      it "should have the currency type" do
        expect( invoice.currency_type ).to be_a_kind_of( String )
        expect( invoice.currency_type ).to eq( 'United States Dollars - USD')
      end 
      
      it "should have the created by id" do
        expect( invoice.created_by ).to be_a_kind_of( Integer )
        expect( invoice.created_by ).to eq( 123456 )
      end
      
      it "should have a number" do
        expect( invoice.number ).to be_a_kind_of( Integer )
        expect( invoice.number ).to eq( 8008 )
      end
      
      it "should have the invoice notes" do
        expect( invoice.notes ).to be_a_kind_of( String )
      end
      
      it "should have a purchase order" do
        expect( invoice.purchase_order ).to be_a_kind_of( String )
      end
      
      it "should have a client key" do
        expect( invoice.client_key ).to be_a_kind_of( String )
        expect( invoice.client_key ).to eq( 'f2a56b1232ad1asdf5926f040e8cff2befb5e8f1' )
      end
      
      it "should have a state" do
        expect( invoice.state ).to be_a_kind_of( String )
        expect( invoice.state ).to eq( 'paid' )
      end
      
      it "should have an applied Tax 1 value" do
        expect( invoice.tax_1 ).to be_a_kind_of( Float )
      end
      
      it "should have an applied Tax 2 value" do
        expect( invoice.tax_2 ).to be_a_kind_of( Float )
      end
      
      it "should have a first tax amount" do
        expect( invoice.tax_1_amount ).to be_a_kind_of( Float )
      end
      
      it "should have the second tax amount" do
        expect( invoice.tax_2_amount ).to be_a_kind_of( Float )
      end
      
      it "should have a discount amount" do
        expect( invoice.discount_amount ).to be_a_kind_of( Float )
        expect( invoice.discount_amount ).to eq( 0.0 )
      end
      
      it "should have a recurring invoice id" do
        expect( invoice.recurring_invoice_id ).to be_a_kind_of( Integer )
      end
      
      it "should have an estimate id" do
        expect( invoice.estimate_id ).to be_a_kind_of( Integer )
      end
      
      it "should have a retainer invoice id" do
        expect( invoice.retainer_invoice_id ).to be_a_kind_of( Integer )
      end
      
      it "should have a created at date" do
        expect( invoice.created_at ).to be_a_kind_of( Date )
        expect( invoice.created_at ).to eq( Date.parse( '2008-04-09T12:07:56Z' ) )
      end
      
      it "should have an updated at date" do
        expect( invoice.updated_at ).to be_a_kind_of( Date )
      end
    end
  end
end