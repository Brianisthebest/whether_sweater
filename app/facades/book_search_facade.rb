class BookSearchFacade
  def get_books(location, quantity)
    @books ||= BookSearchService.new.get_books(location, quantity)

    mapquest = MapquestService.new.get_lat_lng(location)
    lat = mapquest[:results][0][:locations][0][:latLng][:lat]
    lng = mapquest[:results][0][:locations][0][:latLng][:lng]

    weather = WeatherService.new.get_weather(lat, lng)

    books = {destination: location,
      forecast: { summary: weather[:current][:condition][:text],
                    temperature: weather[:current][:temp_f]
                   },
      total_books_found: @books[:numFound],
      books: hash_books(@books)
     }

    Book.new(books)
  end

  def hash_books(book_search)
    book_search[:docs].map do |book|
      {
        isbn: book[:isbn],
        title: book[:title],
        publisher: book[:publisher]
      }
    end
  end
end