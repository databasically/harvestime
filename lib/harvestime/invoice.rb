require 'harvested'
require 'Nokogiri'
module Harvestime
  class Invoice
    
    attr_accessor :amount, :due_amount, :due_date, :human_due_date, :client_id,
                  :currency_type, :purchase_order, :client_key, :state, :tax_1,
                  :tax_2, :tax_1_amount, :tax_2_amount, :discount_amount,
                  :recurring_invoice_id, :estimate_id, :retainer_invoice_id,
                  :updated_at, :id, :created_at, :created_by, :number, :period_end,
                  :period_start, :notes
    
    
    def retrieve( path )
      file     = File.open( path.to_s )
      @invoice = Nokogiri::XML( file )
      instantiate_values
      return :success
    end
    
    def instantiate_values
      @id                   = @invoice.xpath( '//id' ).text.to_i
      @amount               = @invoice.xpath( '//amount' ).text.to_f
      @due_amount           = @invoice.xpath( '//due-amount' ).text.to_f
      @due_date             = parse_date( @invoice.xpath( '//due-at' ).text )
      @human_due_date       = @invoice.xpath( '//due-at-human-format').text 
      @period_end           = parse_date( @invoice.xpath( '//period-end' ).text )
      @period_start         = parse_date( @invoice.xpath( '//period-start').text )
      @client_id            = @invoice.xpath( '//client-id' ).text.to_i
      @currency_type        = @invoice.xpath( '//currency' ).text
      @number               = @invoice.xpath( '//number' ).text.to_i
      @purchase_order       = @invoice.xpath( '//purchase-order' ).text
      @client_key           = @invoice.xpath( '//client-key' ).text
      @state                = @invoice.xpath( '//state' ).text
      @tax_1                = @invoice.xpath( '//tax' ).text.to_f
      @tax_2                = @invoice.xpath( '//tax2' ).text.to_f
      @tax_1_amount         = @invoice.xpath( '//tax-amount' ).text.to_f
      @tax_2_amount         = @invoice.xpath( '//tax-amount2').text.to_f
      @discount_amount      = @invoice.xpath( '//discount-amount' ).text.to_f
      @discount             = @invoice.xpath( '//discount' ).text.to_f
      @recurring_invoice_id = @invoice.xpath( '//recurring-invoice-id' ).text.to_i
      @retainer_invoice_id  = @invoice.xpath( '//retainer-id' ).text.to_i
      @updated_at           = parse_date( @invoice.xpath( '//updated-at' ).text )
      @created_at           = parse_date( @invoice.xpath( '//created-at' ).text )
      @created_by           = @invoice.xpath( '//created-by-id' ).text.to_i
      @notes                = @invoice.xpath( '//notes' ).text
      @estimate_id          = @invoice.xpath( '//estimate-id' ).text.to_i
    end
    
    def parse_date( string )
      Date.parse( string )
    rescue
      Time.new( "" ).to_date
    end
    
  end
end