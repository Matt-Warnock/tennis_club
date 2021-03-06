# frozen_string_literal:true

require 'players'

RSpec.describe Players do
  let(:connection) { PG.connect(dbname: 'tennis_club_test') }

  before do
    clear_test_database
  end

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

    context 'raises an error when' do
      it 'name is too long' do
        one_hundred_chars_name = player
        one_hundred_chars_name[:first_name] = 'john ' * 20

        expect { subject.create(one_hundred_chars_name) }
          .to raise_error PG::StringDataRightTruncation
      end

      it 'date is in wrong format' do
        bad_date_format = player
        bad_date_format[:birth_date] = 'jan 1'

        expect { subject.create(bad_date_format) }
          .to raise_error PG::InvalidDatetimeFormat
      end
    end
  end

  describe '#find' do
    it 'returns the player that matches existing players full name' do
      add_player_to_database

      result = subject.find('john', 'doe')

      expect(result['first_name']).to eq 'john'
    end

    it 'returns an empty hash if no players match full name' do
      result = subject.find('john', 'doe')

      expect(result).to eq({})
    end
  end

  def add_player_to_database
    connection.exec(
      'INSERT INTO players(first_name, last_name, nationality, birth_date)
       VALUES($1, $2, $3, $4);', [
         player[:first_name],
         player[:last_name],
         player[:nationality],
         player[:birth_date]
       ]
    )
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
