module Redshift
  module Rails
    class Railtie < ::Rails::Railtie
      initializer "redshift_rails.initialize" do |app|
        ActiveSupport.on_load(:redshift_client_connection) do
          Redshift::Client.establish_connection
        end

        app.middleware.use Redshift::Rails::Middleware
      end
    end
  end
end
