# frozen_string_literal: true

require_relative '../tennis_club'

RSpec.describe 'tennis_club' do
  def app
    TennisClub
  end

  describe '/v1/players' do
    context 'when successful' do
      before { post '/v1/players', player.to_json }

      it 'sends 200 status' do
        expect(last_response.status).to eq 200
      end

      it 'sends correct content type' do
        expect(last_response.headers['Content-Type']).to eq 'application/json'
      end

      it 'sends valid_json' do
        expect(valid_json?(last_response.body)).to be true
      end
    end

    xcontext 'when player already exists' do
      before do
        Players.new.create(player)
        post '/v1/players', player.to_json
      end

      it 'sends 400 status' do
        expect(last_response.status).to eq 400
      end

      it 'sends error message' do
        error_message = 'Player with same name already exists'

        expect(last_response.body).to include error_message
      end

      it 'sends correct content type' do
        expect(last_response.headers['Content-Type']).to eq 'application/json'
      end

      it 'sends valid_json' do
        expect(valid_json?(last_response.body)).to be true
      end
    end
  end

  def player
    {
      first_name: 'john',
      last_name: 'doe',
      nationality: 'british',
      birth_date: '1990-01-01'
    }
  end

  def valid_json?(json)
    JSON.parse(json)
    true
  rescue JSON::ParserError
    false
  end
end
