require 'harvested'

module Harvestime
  class ClientFilter
    def initialize(interface)
      @interface = interface
    end
    def create_client(client)
      @interface.clients.create(client)
    end
    def build_client(name)
      Harvest::Client.new(name)
    end
    def build_client_from_existing(client)
      build_client(
        )
    end
    def get_all_clients
      @interface.clients.all
    end
  end
end