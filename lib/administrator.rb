# frozen_string_literal: true

class Administrator
  def initialize(players, validator)
    @players = players
    @validator = validator
    @error_messages = {
      bad_data: 'bad or incomplete data',
      under_age: 'player is under 16 years old',
      existing_player: 'player already registered'
    }
  end

  def register_player(player)
    check_data(player)
    downcased_player = lower_casing(player)

    check_existing_player(downcased_player)
    check_age(downcased_player)
    @players.create(downcased_player)
  end

  private

  def check_data(player)
    raise @error_messages[:bad_data] unless @validator.all_data_present?(player)
  end

  def check_age(player)
    birth_year = player[:birth_date]

    raise @error_messages[:under_age] unless @validator.over_sixteen?(birth_year)
  end

  def lower_casing(player)
    player.transform_values(&:downcase)
  end

  def check_existing_player(player)
    player_search = @players.find(player[:first_name], player[:last_name])

    raise @error_messages[:existing_player] unless player_search.empty?
  end
end
