require 'spec_helper'
require 'support/test_application_helper'
require 'rack/test'

describe Redshift::Rails::Middleware do
  include Rack::Test::Methods

  let(:test_app) { TestApplicationHelper::TestApplication.new }
  let(:app) { Redshift::Rails::Middleware.new(test_app) }

  describe "GET '/'" do
    it 'should return 200 OK' do
      get '/'
      expect(last_response.status).to eq 200
    end

    context 'when rack.test is true' do
      before do
        allow(Redshift::Client).to receive :disconnect
      end

      it 'should not call disconnect' do
        get '/'
        expect(Redshift::Client).to_not have_received :disconnect
      end
    end

    context 'when rack.test is false' do
      before do
        allow(Redshift::Client).to receive :disconnect
      end

      it 'should call disconnect' do
        get '/', {}, {'rack.test' => false}
        expect(Redshift::Client).to have_received(:disconnect).once
      end
    end
  end
end
