require 'rails_helper'

RSpec.describe Book do
  describe 'intialize' do
    it 'exists and has attributes' do
      books_data = {destination: "colorado springs,co",
        forecast: { summary: 'cloudy with some meatballs',
                      temperature: 98.0
                     },
        total_books_found: 132,
        books: [{isbn: ["0762507845", "9780762507849"],
                title: "Denver, Co",
                publisher: ["Universal Map Enterprises"]}]
       }

       books = Book.new(books_data)

       expect(books).to be_a(Book)
       expect(books.destination).to eq("colorado springs,co")
       expect(books.forecast).to be_a(Hash)
       expect(books.forecast[:summary]).to eq('cloudy with some meatballs')
       expect(books.forecast[:temperature]).to eq(98.0)
       expect(books.total_books_found).to eq(132)
       expect(books.books).to be_an(Array)
       expect(books.books[0]).to be_a(Hash)
       expect(books.books[0][:isbn]).to eq(["0762507845", "9780762507849"])
       expect(books.books[0][:title]).to eq("Denver, Co")
       expect(books.books[0][:publisher]).to eq(["Universal Map Enterprises"])
    end
  end
end