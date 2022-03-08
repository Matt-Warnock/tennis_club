# frozen_string_literal: true

require 'sinatra'

class TennisClub < Sinatra::Base
  before do
    content_type :json
  end

  post '/v1/players' do
    { player: 'added to database' }.to_json
  end
end
