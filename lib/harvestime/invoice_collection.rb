module Harvestime
  class InvoiceCollection
    
    def initialize( *args )
      @container = []
      self.add( args )
    end
    
    def add( *args )
      @container.concat( args )
      clean_up
      args
    end
    
    def retrieve
      @container
    end
    
    def clean_up
      @container.flatten!
      @container.uniq!
    end
  end
end