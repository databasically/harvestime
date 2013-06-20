require'harvested'
require'harvestime'
module Harvestime 
  class InvoiceFilter
    def all_with_status( state )
        harvest.invoices.all( status: state.to_s )
    end
      
    def all_invoices
      harvest.invoices.all 
    end
    
    def outstanding_invoices
      all_with_status( :unpaid )
    end
    
    def draft_invoices
      all_with_status( :draft ) 
    end
    
    def partial_invoices
      all_with_status( :partial )
    end
    
    def unpaid_invoices
      all_with_status( :unpaid )
    end
    
    def paid_invoices
      all_with_status( :paid )
    end
    
    def all_by_client_id(client_id)
      invoices = all_invoices
      collection = []
      invoices.each |invoice| do
        collection << invoice if invoice.client_id = client_id
      end
      collection
    end
    
    def all_with_status_and_client( state, client_id)
      invoices = all_with_status( state )
      collection = []
      invoices.each |invoice| do
        collection << inoice if invoice.client_id = client_id
      end
      collection
    end
    
    def outstanding_by_client_id( client_id)
      all_with_status_and_client( :unpaid, client_id )
    end
    
    
  # TODO: Put this at a higher scope
    def harvest_client
      Harvest.hardy_client('sandboxbasically', 'nick.s.fausnight@gmail.com', 'sandbox')
    end
    
    
  # TODO: MAKE SOMETHING LIKE THIS, BUILD CLIENT OUTSIDE 
   def harvest
     @harvest ||= harvest_client
   end
    
  end
end