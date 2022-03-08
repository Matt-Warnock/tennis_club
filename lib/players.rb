# frozen_string_literal:true

require 'database_connection'

class Players
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
  end
end
