module Redshift
  module Rails
    class Railtie < ::Rails::Railtie
      initializer "redshift_rails.initialize" do |app|
        ActiveSupport.on_load(:redshift_client_connection) do
          Redshift::Client.establish_connection Redshift::Rails.config.database
        end

        app.middleware.use Redshift::Rails::Middleware
      end

      config.before_configuration do
        config.redshift = ActiveSupport::OrderedOptions.new
        config.redshift.config_file = "#{::Rails.root}/config/redshift.yml"
      end

      config.after_initialize do
        Redshift::Rails.config.load!
      end
    end
  end
end
