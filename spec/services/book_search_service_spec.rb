require 'rails_helper'

RSpec.describe BookSearchService do
  describe 'get_books', :vcr do
    it 'returns a hash', :vcr do
      location = 'denver, co'

      expect(BookSearchService.new.get_books(location, 5)).to be_a(Hash)
    end
  end
end