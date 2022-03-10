# frozen_string_literal: true

class Validator
  def all_data_present?(player)
    required_keys = %i[first_name last_name nationality birth_date]

    required_keys.all? { |key| player.key?(key) }
  end
end
