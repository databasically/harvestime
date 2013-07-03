require 'harvested'

require 'harvestime/version'
require 'harvestime/invoice_collection'
require 'harvestime/invoice_filter'
require 'harvestime/time_filter'
require 'harvestime/invoice'
require 'harvestime/interface'

module Harvestime
  def self.interface(subdomain, username, password)
       Harvestime::Interface.new(subdomain, username, password)
  end
end