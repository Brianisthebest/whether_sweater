class Api::V1::BooksController < ApplicationController
  def index
    book_search = BookSearchFacade.new.get_books(params[:location], params[:quantity])

    render json: BooksSerializer.new(book_search)
  end
end