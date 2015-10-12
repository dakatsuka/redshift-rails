module Redshift
  module Rails
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        testing = env['rack.test']

        response = @app.call(env)
        response[2] = ::Rack::BodyProxy.new(response[2]) do
          Redshift::Client.disconnect unless testing
        end

        response
      rescue Exception
        Redshift::Client.disconnect unless testing
        raise
      end
    end
  end
end
