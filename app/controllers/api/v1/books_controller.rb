class Api::V1::BooksController < ApplicationController
  def index
    if params[:location].empty?
      render json: { error: 'Please provide a location' }, status: 400
    elsif params[:quantity].to_i < 1
      render json: { error: 'Please provide a valid quantity' }, status: 400
    else
      book_search = BookSearchFacade.new.get_books(params[:location], params[:quantity])
      render json: BooksSerializer.new(book_search)
    end
  end
end