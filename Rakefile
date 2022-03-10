# frozen_string_literal: true

require 'pg'

namespace :db do
  sql = File.open('./db/migrations/create_tables.sql').read
  players = File.open('./db/migrations/insert_test_players.sql').read

  task :local_setup do
    puts 'Creating databases...'

    %w[tennis_club tennis_club_test].each do |database|
      connection = PG.connect

      connection.exec("CREATE DATABASE #{database};")

      connection = PG.connect(dbname: database)

      connection.exec(sql)
    end
  end

  task :seed_players do
    puts 'Inserting players...'
    connection = PG.connect(dbname: 'tennis_club_test')
    connection.exec(players)
  end
end
