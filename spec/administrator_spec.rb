# frozen_string_literal: true

require 'administrator'
require 'validator'

RSpec.describe Administrator do
  describe '#register_player' do
    let(:players) { double('Players') }
    let(:validator) { Validator.new }
    let(:administrator) { described_class.new(players, validator) }

    before do
      allow(players).to receive(:create)
      allow(players).to receive(:find)
        .with(good_data[:first_name], good_data[:last_name])
        .and_return({})
    end

    context 'when data is good' do
      it 'calls players with data' do
        expect(players).to receive(:create).with(good_data)

        administrator.register_player(good_data)
      end

      it 'calls players with data strings in lowercasing' do
        expect(players).to receive(:create).with(good_data)

        administrator.register_player(data_capitalized_strings)
      end

      it 'checks if the player is already registered' do
        expect(players).to receive(:find).with(good_data[:first_name], good_data[:last_name])

        administrator.register_player(good_data)
      end

      it 'checks player name in lowercasing' do
        expect(players).to receive(:find).with(good_data[:first_name], good_data[:last_name])

        administrator.register_player(data_capitalized_strings)
      end
    end

    context 'when data is incomplete' do
      let(:incomplete_data) { { first_name: 'john' } }

      it 'raises error' do
        expect { administrator.register_player(incomplete_data) }
          .to raise_error 'bad or incomplete data'
      end
    end

    context 'when player is already registered' do
      before do
        allow(players).to receive(:find)
          .with(good_data[:first_name], good_data[:last_name])
          .and_return(good_data)
      end

      it 'raises error' do
        expect { administrator.register_player(good_data) }
          .to raise_error 'player already registered'
      end
    end

    it 'raises error when player is under 16 years old' do
      expect { administrator.register_player(under_age_player) }
        .to raise_error 'player is under 16 years old'
    end
  end

  def good_data
    {
      first_name: 'john',
      last_name: 'doe',
      nationality: 'british',
      birth_date: '1990-01-01'
    }
  end

  def under_age_player
    fifteen_years_ago = Time.now.year - 15
    good_data.update({ birth_date: "#{fifteen_years_ago}-01-01" })
  end

  def data_capitalized_strings
    good_data.transform_values(&:capitalize)
  end
end
