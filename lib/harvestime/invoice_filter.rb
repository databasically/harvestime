require'harvested'
module Harvestime 
  class InvoiceFilter
    
    def initialize(client)
      @client = client
    end
    
    def all_with_status( state )
      @client.invoices.all( status: state.to_s )
    end
      
    def all_invoices
      @client.invoices.all 
    end

    def all_by_client_id( client_id )
      collection = []
      all_invoices.each do |invoice|
        collection << invoice if invoice.client_id == client_id
      end
      collection
    end
    
    def all_with_status_and_client( state, client_id )
      collection = []
      all_with_status( state ).each do |invoice|
        collection << invoice if invoice.client_id == client_id
      end
      collection
    end
    # # Unnecessary  
    # def outstanding_invoices
    #   all_with_status( :unpaid )
    # end
    
    # def draft_invoices
    #   all_with_status( :draft ) 
    # end
    
    # def partial_invoices
    #   all_with_status( :partial )
    # end
    
    # def unpaid_invoices
    #   all_with_status( :unpaid )
    # end
    
    # def paid_invoices
    #   all_with_status( :paid )
    # end
    
    # # coupled 
    # def outstanding_by_client_id( client_id )
    #   all_with_status_and_client( :unpaid, client_id )
    # end
  end
end