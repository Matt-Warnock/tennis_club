# frozen_string_literal: true

class Administrator
  def initialize(players)
    @players = players
  end

  def register_player(player)
    return raise 'bad or incomplete data' unless all_data_present?(player)

    @players.create(player)
  end

  def all_data_present?(player)
    required_keys = %i[first_name last_name nationality birth_date]

    required_keys.all? { |key| player.key?(key) }
  end
end
