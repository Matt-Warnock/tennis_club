# frozen_string_literal: true

require 'validator'

RSpec.describe Validator do
  describe '#all_data_present?' do
    it 'returns true if all_expected keys are present' do
      result = subject.all_data_present?(valid_data)

      expect(result).to eq true
    end

    it 'returns true if all_expected keys are present' do
      result = subject.all_data_present?(incomplete_data)

      expect(result).to eq false
    end
  end

  describe '#over_sixteen?' do
    it 'returns true if birth date is at least 16 years ago' do
      over_sixteen_years_ago = "#{Time.now.year - 16}-01-01"

      result = subject.over_sixteen?(over_sixteen_years_ago)

      expect(result).to eq true
    end

    it 'returns false if birth date is under 16 years ago' do
      under_sixteen_years_ago = "#{Time.now.year - 15}-01-01"

      result = subject.over_sixteen?(under_sixteen_years_ago)

      expect(result).to eq false
    end
  end

  def incomplete_data
    {
      first_name: 'john',
      nationality: 'british',
      birth_date: '1990-01-01'
    }
  end

  def valid_data
    {
      first_name: 'john',
      last_name: 'doe',
      nationality: 'british',
      birth_date: '1990-01-01'
    }
  end
end
