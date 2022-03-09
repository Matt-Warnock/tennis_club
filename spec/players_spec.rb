# frozen_string_literal:true

require 'players'

RSpec.describe Players do
  let(:connection) { PG.connect(dbname: 'tennis_club_test') }

  describe '#create' do
    context 'when adding a new player to the database' do
      before do
        subject.create(player)
      end

      it 'adds the first name' do
        expect(database_player['first_name']).to eq player[:first_name]
      end

      it 'adds the last name' do
        expect(database_player['last_name']).to eq player[:last_name]
      end

      it 'adds the nationality' do
        expect(database_player['nationality']).to eq player[:nationality]
      end

      it 'adds the birth date' do
        expect(database_player['birth_date']).to eq player[:birth_date]
      end

      it 'creates a player id' do
        expect(database_player['player_id']).to match(/\d+/)
      end

      it 'creates a player score of 1200' do
        expect(database_player['score']).to eq '1200'
      end
    end

    context 'when data exceeds database constraints' do
      it 'does not raise an error' do
        one_hundred_chars_name = player
        one_hundred_chars_name[:first_name] = 'john ' * 20

        expect { subject.create(one_hundred_chars_name) }.to_not raise_error
      end

      it 'logs an error' do
        bad_date_format = player
        bad_date_format[:birth_date] = 'january 1'

        expect { subject.create(bad_date_format) }
          .to change { subject.error_message }
          .from(nil).to(String)
      end
    end
  end

  def database_player
    connection.exec('SELECT * FROM players;').first
  end

  def player
    {
      first_name: 'john',
      last_name: 'doe',
      nationality: 'british',
      birth_date: '1990-01-01'
    }
  end
end
