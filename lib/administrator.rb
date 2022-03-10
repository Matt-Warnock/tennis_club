# frozen_string_literal: true

class Administrator
  def initialize(players)
    @players = players
  end

  def register_player(player)
    check_data(player)
    downcased_player = lower_casing(player)

    check_existing_player(downcased_player)
    @players.create(downcased_player)
  end

  private

  def check_data(player)
    raise 'bad or incomplete data' unless all_data_present?(player)
  end

  def lower_casing(player)
    player.transform_values(&:downcase)
  end

  def all_data_present?(player)
    required_keys = %i[first_name last_name nationality birth_date]

    required_keys.all? { |key| player.key?(key) }
  end

  def check_existing_player(player)
    player_search = @players.find(player[:first_name], player[:last_name])

    raise 'player already registered' unless player_search.empty?
  end
end
