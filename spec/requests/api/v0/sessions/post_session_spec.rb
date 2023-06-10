require 'rails_helper'

RSpec.describe 'Sessions API' do
  describe 'POST /api/v0/sessions' do
    it 'returns a user if credentials are correct' do
      user = create(:user)

      user_params = {
        "email": user.email,
        "password": user.password,
        "password_confirmation": user.password
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v0/sessions", headers: headers, params: JSON.generate(session: user_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:type]).to eq('users')
      expect(json[:data][:id]).to eq(user.id.to_s)
      expect(json[:data][:attributes][:email]).to eq(user.email)
      expect(json[:data][:attributes][:api_key]).to eq(user.api_key)
    end

    it 'returns a vague error message if password is incorrect' do
      user = create(:user)

      user_params = {
        "email": user.email,
        "password": user.password,
        "password_confirmation": "wrongpassword"
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v0/sessions", headers: headers, params: JSON.generate(session: user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:error)
      expect(json[:error]).to eq("Invalid credentials")
    end

    it 'returns a vague error message if email is not found' do
      user = create(:user)

      user_params = {
        "email": "nottherightemail@gmail.com",
        "password": user.password,
        "password_confirmation": user.password
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v0/sessions", headers: headers, params: JSON.generate(session: user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:error)
      expect(json[:error]).to eq("Invalid credentials")
    end
  end
end