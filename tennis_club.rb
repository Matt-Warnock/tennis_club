# frozen_string_literal: true

require 'sinatra'
require_relative './lib/players'
require_relative './lib/administrator'
require_relative './lib/validator'

class TennisClub < Sinatra::Base
  before do
    content_type :json
  end

  post '/v1/players' do
    administrator = Administrator.new(Players.new, Validator.new)
    data = JSON.parse(request.body.read, { symbolize_names: true })

    administrator.register_player(data)
    { player: 'added to database' }.to_json

  rescue RuntimeError, JSON::ParserError, PG::Error => e
    status 400
    body({ error: e.message }.to_json)
  end
end
