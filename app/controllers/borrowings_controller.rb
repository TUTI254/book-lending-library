class BorrowingsController < ApplicationController
  before_action :authenticate
  before_action :find_book, only: [ :create ]
  before_action :find_borrowing, only: [ :return ]

  def index
    @borrowings = current_user.borrowings.where(returned: false)
  end

  def create
    if @book.nil?
      redirect_to books_path, alert: "Book not found."
      return
    end

    if @book.available?
      @borrowing = current_user.borrowings.create(book: @book, returned: false)
      if @borrowing.persisted?
        Rails.cache.delete("books_list")
        redirect_to books_path, notice: "You have borrowed '#{@book.title}'."
      else
        redirect_to books_path, alert: "You already borrowed this book."
      end
    else
      redirect_to books_path, alert: "This book is not available for borrowing."
    end
  end

  def return
    if @borrowing
      @borrowing.update(returned: true)
      Rails.cache.delete("books_list")
      redirect_to borrowings_path, notice: "You have returned '#{@borrowing.book.title}'."
    else
      redirect_to borrowings_path, alert: "You cannot return a book you haven't borrowed."
    end
  end

  private

  def find_book
    book_id = params[:book_id] || params.dig(:borrowing, :book_id)
    @book = Book.find_by(id: book_id)

    redirect_to books_path, alert: "Book not found." unless @book
  end

  def find_borrowing
    @borrowing = current_user.borrowings.find_by(id: params[:id])

    unless @borrowing
      redirect_to borrowings_path, alert: "Borrowing record not found."
      return
    end

    @book = @borrowing.book
  end
end
