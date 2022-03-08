# frozen_string_literal: true

require_relative '../tennis_club'

RSpec.describe 'tennis_club' do
  def app
    TennisClub
  end

  describe '/v1/players' do
    before { post '/v1/players' }

    it 'is successful' do
      expect(last_response).to be_ok
    end

    it 'sends correct content type' do
      expect(last_response.headers['Content-Type']).to eq 'application/json'
    end

    it 'sends valid_json' do
      expect(valid_json?(last_response.body)).to be true
    end
  end

  def valid_json?(json)
    JSON.parse(json)
    true
  rescue JSON::ParserError
    false
  end
end
