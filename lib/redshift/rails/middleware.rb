module Redshift
  module Rails
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        @app.call(env)
      ensure
        Redshift::Client.disconnect
      end
    end
  end
end
