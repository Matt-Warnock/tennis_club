# frozen_string_literal:true

require 'database_connection'

class Players
  attr_reader :error_message

  def initialize
    @error_message = nil
  end

  def create(player)
    DatabaseConnection.query(
      'INSERT INTO players(first_name, last_name, nationality, birth_date)
       VALUES($1, $2, $3, $4);', order_in_array(player)
    )
  rescue PG::Error => e
    @error_message = e.message
  end

  def find(first_name, last_name)
    result = DatabaseConnection.query(
      'SELECT * FROM players
       WHERE first_name=$1 AND last_name=$2;', [first_name, last_name]
    )
    result.first || {}
  end

  private

  def order_in_array(player)
    [
      player[:first_name],
      player[:last_name],
      player[:nationality],
      player[:birth_date]
    ]
  end
end
