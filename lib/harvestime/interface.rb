require 'harvested'
module Harvestime
  class Interface
    attr_accessor :client_filter, :invoice_filter, :time_filter
    def initialize(subdomain, username, password)
      @interface      = Harvest.hardy_client(subdomain, username, password)
      # @client_filter  = Harvestime::ClientFilter.new(@interface)
      @invoice_filter = Harvestime::InvoiceFilter.new(@interface)
      @time_filter    = Harvestime::TimeFilter.new(@interface)
    end
  end
end