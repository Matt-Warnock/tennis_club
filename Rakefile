# frozen_string_literal: true

require 'pg'

namespace :db do
  sql = File.open('./db/migrations/create_tables.sql').read

  task :local_setup do
    puts 'Creating databases...'

    %w[tennis_club tennis_club_test].each do |database|
      connection = PG.connect

      connection.exec("CREATE DATABASE #{database};")

      connection = PG.connect(dbname: database)

      connection.exec(sql)
    end
  end
end
