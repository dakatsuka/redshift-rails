require 'active_support/configurable'
require 'yaml'
require 'erb'
require 'uri'

module Redshift
  module Rails
    class << self
      def config
        Configuration.instance
      end
    end

    class Configuration
      include Singleton
      include ActiveSupport::Configurable

      config_accessor :host, :port, :user, :password, :dbname

      def load!
        resolve_config.each do |k, v|
          send("#{k}=", v)
        end
      end

      def database
        {
          host: host,
          port: port,
          user: user,
          password: password,
          dbname: dbname
        }
      end

      private
      def resolve_config
        config_file = ::Rails.application.config.redshift.config_file

        if File.exists?(config_file)
          YAML.load(ERB.new(File.read(config_file)).result)[::Rails.env]
        else
          uri = URI.parse(ENV["REDSHIFT_URL"])
          {
            host: uri.host,
            port: uri.port,
            user: uri.user,
            password: uri.password,
            dbname: uri.path[1..-1]
          }
        end
      end
    end
  end
end
