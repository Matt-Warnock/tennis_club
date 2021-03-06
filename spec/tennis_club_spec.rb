# frozen_string_literal: true

require_relative '../tennis_club'

RSpec.describe 'tennis_club' do
  def app
    TennisClub
  end

  describe '/v1/players' do
    before do
      clear_test_database
    end

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

      it 'adds player to the database' do
        expect(database_find(player)).to include(player)
      end
    end

    context 'when player already exists' do
      before do
        Players.new.create(player)
        post '/v1/players', player.to_json
      end

      it 'sends 400 status' do
        expect(last_response.status).to eq 400
      end

      it 'sends error message' do
        error_message = 'player already registered'

        expect(last_response.body).to include error_message
      end

      it 'sends correct content type' do
        expect(last_response.headers['Content-Type']).to eq 'application/json'
      end

      it 'sends valid_json' do
        expect(valid_json?(last_response.body)).to be true
      end
    end

    it 'finds existing player when adding player with capitalized name' do
      capitalized_player = player.update({ first_name: 'John' })
      error_message = 'player already registered'

      Players.new.create(player)

      post '/v1/players', capitalized_player.to_json

      expect(last_response.body).to include error_message
    end

    context 'when invalid json request' do
      before do
        post '/v1/players', { irrelevant: 'value' }
      end

      it 'sends 400 status' do
        expect(last_response.status).to eq 400
      end

      it 'sends error message' do
        error_message = 'unexpected token'

        expect(last_response.body).to include error_message
      end
    end

    context 'when database errors' do
      before do
        one_hundred_chars_name = 'John ' * 20
        bad_data = player.update({ first_name: one_hundred_chars_name })

        post '/v1/players', bad_data.to_json
      end

      it 'sends 400 status' do
        expect(last_response.status).to eq 400
      end

      it 'sends error message' do
        error_message = 'value too long'

        expect(last_response.body).to include error_message
      end
    end
  end

  def database_find(player)
    Players
      .new
      .find(player[:first_name], player[:last_name])
      .transform_keys(&:to_sym)
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
