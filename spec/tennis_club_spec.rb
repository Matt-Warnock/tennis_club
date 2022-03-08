# frozen_string_literal: true

require_relative '../tennis_club'

RSpec.describe 'tennis_club' do
  def app
    TennisClub
  end

  describe '/v1/players' do
    it 'is successful' do
      post '/v1/players'

      expect(last_response).to be_ok
    end
  end
end
