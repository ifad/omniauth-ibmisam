require 'spec_helper'

describe OmniAuth::Strategies::Ibmisam, type: :strategy do
  include Rack::Test::Methods

  let(:name) { "ibmisam" }

  let(:request_path) { "/auth/" + name }

  let(:callback_path) { "/auth/" + name + "/callback" }

  let(:app) do
    strategy_name = name
    Rack::Builder.new do |b|
      b.use OmniAuth::Test::PhonySession
      b.use OmniAuth::Strategies::Ibmisam, name: strategy_name, header_type: :identity
      b.run lambda { |env|
        [200, {'Content-Type' => 'text/plain'}, [env.key?('omniauth.auth').to_s]]
      }
    end.to_app
  end

  let(:unauthorized_message) { "Unauthorized (Missing external authentication)" }

  describe '#request_phase' do
    subject { last_response }

    context 'without a header' do
      before { get request_path }

      it 'does not authenticate' do
        expect(last_response.body).to eq unauthorized_message
      end
    end

    context 'with a header that has no value' do
      before do
        header('iv-user', nil)
        get request_path
      end

      it 'responds with failure' do
        expect(last_response.status).to eq 401
      end

      it 'includes unauthorized message' do
        expect(last_response.body).to eq unauthorized_message
      end
    end

    context 'with a header that has a value' do
      before do
        header('iv-user', 'test@example.com')
        get request_path
      end

      it 'redirects' do
        expect(last_response.status).to eq 302
      end

      it 'redirects to the callback' do
        expect(last_response.location).to eq callback_path
      end
    end
  end
end
