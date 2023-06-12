require 'rails_helper'

RSpec.describe BookSearchFacade do
  describe 'get_books' do
    it 'returns a book object' do
      book_search = BookSearchFacade.new.get_books('denver, co', 5)

      expect(book_search).to be_a(BookSearch)
      expect(book_search.id).to eq('null')
      expect(book_search.type).to eq('books')
      expect(book_search.destination).to eq('denver, co')
      expect(book_search.forecast).to be_a(Hash)
      expect(book_search.forecast[:summary]).to be_a(String)
      expect(book_search.forecast[:temperature]).to be_a(Float)
      expect(book_search.total_books_found).to be_an(Integer)
      expect(book_search.books).to be_an(Array)
      expect(book_search.books[0]).to have_key(:isbn)
      expect(book_search.books[0]).to have_key(:title)
      expect(book_search.books[0]).to have_key(:publisher)
    end
  end
end