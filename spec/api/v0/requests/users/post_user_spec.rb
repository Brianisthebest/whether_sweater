require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'POST /api/v0/users' do
    it 'creates a user' do
      user_params = {
                      'email': 'jimmy@johns.edu',
                      'password': 'password',
                      'password_confirmation': 'password'
                    }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

      created_user = User.last
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(json[:data][:type]).to eq('users')
      expect(json[:data][:id]).to eq(created_user.id.to_s)
      expect(json[:data][:attributes][:email]).to eq(created_user.email)
      expect(json[:data][:attributes][:api_key]).to eq(created_user.api_key)
    end
  end
end