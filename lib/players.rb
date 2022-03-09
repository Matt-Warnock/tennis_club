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
       VALUES($1, $2, $3, $4);',
      [
        player[:first_name],
        player[:last_name],
        player[:nationality],
        player[:birth_date]
      ]
    )
  rescue PG::Error => e
    @error_message = e.message
  end
end
