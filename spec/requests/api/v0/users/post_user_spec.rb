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

      post '/api/v0/users', headers: headers, params: JSON.generate(user: user_params)

      created_user = User.last
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(json[:data][:type]).to eq('users')
      expect(json[:data][:id]).to eq(created_user.id.to_s)
      expect(json[:data][:attributes][:email]).to eq(created_user.email)
      expect(json[:data][:attributes][:api_key]).to eq(created_user.api_key)
    end

    it 'sends an error if passwords do not match' do
      user_params = {
        'email': 'jimmy@johns.edu',
        'password': 'password',
        'password_confirmation': 'password123'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/users', headers: headers, params: JSON.generate(user: user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:error)
      expect(json[:error]).to eq("Validation failed: Password confirmation doesn't match Password")
    end

    it 'send an error if email is already taken' do
      User.create!(email: 'alreadytaken@gmail.com', password: 'password', password_confirmation: 'password')
      
      user_params = {
        'email': 'alreadytaken@gmail.com',
        'password': 'password',
        'password_confirmation': 'password123'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/users', headers: headers, params: JSON.generate(user: user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:error)
      expect(json[:error]).to eq("Validation failed: Email must be unique")
    end
  end
end