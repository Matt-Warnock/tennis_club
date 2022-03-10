# frozen_string_literal: true

require './lib/database_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('tennis_club_test')
elsif ENV['RACK_ENV'] == 'production'
  DatabaseConnection.remote_connection(ENV['DATABASE_URL'])
else
  DatabaseConnection.setup('tennis_club')
end
