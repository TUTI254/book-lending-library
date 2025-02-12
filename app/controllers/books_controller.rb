class BooksController < ApplicationController
  skip_before_action :authenticate, only: %i[index show]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end
end
