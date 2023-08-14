require 'rails_helper'
require 'benchmark'

RSpec.describe 'Performance', type: :request do
  let(:user) do
    User.create!(name: 'John', email: 'test@test.com', password: 'testpassword')
  end

  describe 'Find CEP' do
    it 'measures the execution time' do
      user.generate_token
      execution_time = Benchmark.realtime do
        get find_addresses_path, params: { password: user.password, cep: '01311100' },
                                 headers: { Authorization: "Bearer #{user.token}" }
      end

      expect(execution_time).to be < 1.0
    end
  end
end
