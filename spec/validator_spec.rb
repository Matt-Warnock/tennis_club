# frozen_string_literal: true

require 'validator'

RSpec.describe Validator do
  describe '#all_data_present' do
    it 'returns true if all_expected keys are present' do
      result = subject.all_data_present?(valid_data)

      expect(result).to eq true
    end

    it 'returns true if all_expected keys are present' do
      result = subject.all_data_present?(incomplete_data)

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
