# frozen_string_literal: true

class Validator
  def all_data_present?(player)
    required_keys = %i[first_name last_name nationality birth_date]

    required_keys.all? { |key| player.key?(key) }
  end

  def over_sixteen?(birth_date)
    birth_date_year = birth_date[0, 4].to_i
    (Time.now.year - birth_date_year) >= 16
  end
end
