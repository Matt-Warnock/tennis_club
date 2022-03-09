# frozen_string_literal: true

require 'sinatra'
require_relative './lib/players'

class TennisClub < Sinatra::Base
  before do
    content_type :json
  end

  post '/v1/players' do
    { player: 'added to database' }.to_json
  end
end
