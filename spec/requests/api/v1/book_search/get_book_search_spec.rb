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
  end
end

# {
#   "data": {
#     "id": "null",
#     "type": "books",
#     "attributes": {
#       "destination": "denver,co",
#       "forecast": {
#         "summary": "Cloudy with a chance of meatballs",
#         "temperature": "83 F"
#       },
#       "total_books_found": 172,
#       "books": [
#         {
#           "isbn": [
#             "0762507845",
#             "9780762507849"
#           ],
#           "title": "Denver, Co",
#           "publisher": [
#             "Universal Map Enterprises"
#           ]
#         },
#         {
#           "isbn": [
#             "9780883183663",
#             "0883183668"
#           ],
#           "title": "Photovoltaic safety, Denver, CO, 1988",
#           "publisher": [
#             "American Institute of Physics"
#           ]
#         },
#         { ... same format for books 3, 4 and 5 ... }
#       ]
#     }
#   }
# }