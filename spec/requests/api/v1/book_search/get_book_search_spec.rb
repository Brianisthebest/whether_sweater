require 'rails_helper'

RSpec.describe 'Book Search API' do
  describe 'GET /api/v1/book_search' do
    it 'returns a destination city, forecast in the city right now, total nuber of search results, a quantity of books about the city' do
      get "/api/v1/book-search?location=denver,co&quantity=5"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json[:data]).to be_a(Hash)
      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to eq('null')
      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to eq('books')
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes]).to have_key(:destination)
      expect(json[:data][:attributes]).to have_key(:forecast)
      expect(json[:data][:attributes][:forecast]).to be_a(Hash)
      expect(json[:data][:attributes][:forecast]).to have_key(:summary)
      expect(json[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(json[:data][:attributes]).to have_key(:total_books_found)
      expect(json[:data][:attributes]).to have_key(:books)
      expect(json[:data][:attributes][:books]).to be_a(Array)
      expect(json[:data][:attributes][:books].count).to eq(5)
      expect(json[:data][:attributes][:books][0]).to be_a(Hash)
      expect(json[:data][:attributes][:books][0]).to have_key(:isbn)
      expect(json[:data][:attributes][:books][0]).to have_key(:title)
      expect(json[:data][:attributes][:books][0]).to have_key(:publisher)
    end

    it 'returns a 400 error if no location is provided' do
      get "/api/v1/book-search?location=&quantity=5"

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:error]).to eq('Please provide a location')
    end

    it 'returns a 400 error if the quantity is less than 1' do
      get "/api/v1/book-search?location=denver,co&quantity=-1"

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:error]).to eq('Please provide a valid quantity')
    end
  end
end