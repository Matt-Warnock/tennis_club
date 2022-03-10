# frozen_string_literal: true

class Administrator
  def initialize(players)
    @players = players
  end

  def register_player(player)
    check_data(player)
    check_existing_player(player)

    @players.create(player)
  end

  private

  def check_data(player)
    raise 'bad or incomplete data' unless all_data_present?(player)
  end

  def all_data_present?(player)
    required_keys = %i[first_name last_name nationality birth_date]

    required_keys.all? { |key| player.key?(key) }
  end

  def check_existing_player(player)
    first_name = player[:first_name].downcase
    last_name = player[:last_name].downcase

    player_search = @players.find(first_name, last_name)

    raise 'player already registered' unless player_search.empty?
  end
end
