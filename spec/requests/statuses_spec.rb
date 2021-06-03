# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Statuses', type: :request do
  describe 'GET /status' do
    it 'response success' do
      get '/status'

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({ status: 'ok' }.to_json)
      expect(response.media_type).to eq('application/json')
    end
  end
end
