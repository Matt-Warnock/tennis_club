# frozen_string_literal: true

class Ranker
  def initialize
    @ranks = ['bronze', 'silver', 'gold', 'supersonic legend']
    @ranges = [0...2999, 3000...4999, 5000...9999, 10_000...]
  end

  def assign_ranks(players)
    ranked_players = rank_each_player(players)

    ranked_players.sort_by { |p| p['score'].to_i }.reverse
  end

  private

  def rank_each_player(players)
    players.each do |player|
      next player['rank'] = 'unranked' if qualifyed_for_ranking?(player)

      rank(player)
    end
  end

  def qualifyed_for_ranking?(player)
    player['games_played'].to_i < 3
  end

  def rank(player)
    @ranges.each_with_index do |range, i|
      player['rank'] = @ranks[i] if in_range?(range, player)
    end
  end

  def in_range?(range, player)
    range.include?(player['score'].to_i)
  end
end
