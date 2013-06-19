require'harvested'
module Harvestime
  class InvoiceFilter
    
    def initialize( harvest )
      @harvest = harvest
    end
    
    def all_with_status( state )
        Harvestime::InvoiceCollection.new( @harvest.invoices.all( status: state ) )
    end
      
    def all_invoices
      Harvestime::InvoiceCollection.new( @harvest.invoices.all )
    end
    
    def draft_invoices
      all_with_status( 'draft' ) 
    end
    
    def partial_invoices
      all_with_status( 'partial' )
    end
    
    def unpaid_invoices
      all_with_status( 'unpaid' )
    end
    
    def paid_invoices
      all_with_status( 'paid' )
    end
    
    
  end
end