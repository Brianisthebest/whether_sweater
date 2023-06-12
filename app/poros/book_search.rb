class BookSearch
  attr_reader :id, 
              :type,
              :destination,
              :forecast,
              :total_books_found,
              :books
              
  def initialize(data)
    @id = 'null'
    @type = 'books'
    @destination = data[:destination]
    @forecast = data[:forecast]
    @total_books_found = data[:total_books_found]
    @books = data[:books]
  end
end