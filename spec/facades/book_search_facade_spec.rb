require 'rails_helper'

RSpec.describe BookSearchFacade do
  describe 'get_books' do
    it 'returns a book object' do
      book_search = BookSearchFacade.new.get_books('denver, co', 5)

      expect(book_search).to be_a(BookSearch)
    end
  end
end