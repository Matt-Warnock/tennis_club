# frozen_string_literal: true

require 'ranker'

RSpec.describe Ranker do
  let(:connection) { PG.connect(dbname: 'tennis_club_test') }
  let(:seed_sql) { File.open('./db/migrations/insert_test_players.sql') }

  before do
    clear_test_database
    connection.exec(seed_sql.read)
  end

  describe '#assign_ranks' do
    it 'gives silver rank to player with score in range 3000...4999' do
      ranked_players = subject.assign_ranks(all_database_players)
      range = (3000...49_999)

      silver_player = select_by_score_range(ranked_players, range).first

      expect(silver_player['rank']).to eq 'silver'
    end

    it 'gives bronze rank to player with score in range 0...2999' do
      ranked_players = subject.assign_ranks(all_database_players)
      range = (0...2999)

      bronze_player = select_by_score_range(ranked_players, range).first

      expect(bronze_player['rank']).to eq 'bronze'
    end

    it 'gives gold rank to player with score in range 5000...9999' do
      ranked_players = subject.assign_ranks(all_database_players)
      range = (5000...9999)

      gold_player = select_by_score_range(ranked_players, range).first

      expect(gold_player['rank']).to eq 'gold'
    end

    it 'gives supersonic_legend rank to player with score in range 10000 up' do
      ranked_players = subject.assign_ranks(all_database_players)
      range = (10_000...)

      supersonic_player = select_by_score_range(ranked_players, range).first

      expect(supersonic_player['rank']).to eq 'supersonic legend'
    end

    it 'gives rank of "unranked" to all that has played under 3 games' do
      ranked_players = subject.assign_ranks(all_database_players)

      unranked = ranked_players.filter { |player| player['games_played'].to_i < 3 }
      result = unranked.all? { |player| player['rank'] == 'unranked' }

      expect(result).to eq true
    end
  end

  def select_by_score_range(players, range)
    players.filter { |player| range.include?(player['score'].to_i) }
  end

  def all_database_players
    result = connection.exec('SELECT * FROM players;')
    result.map { |player| player }
  end
end
