# frozen_string_literal: true

require 'pg'

def clear_test_database
  connection = PG.connect(dbname: 'tennis_club_test')
  connection.exec('TRUNCATE players;')
end
