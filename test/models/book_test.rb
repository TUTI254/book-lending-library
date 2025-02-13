require "test_helper"

class BookTest < ActiveSupport::TestCase
  def setup
    @book = Book.new(title: "Sample Book", author: "John Doe", isbn: "1234567890", cover: "cover_url")
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "should require title, author, isbn, and cover" do
    @book.title = ""
    assert_not @book.valid?

    @book.author = ""
    assert_not @book.valid?

    @book.isbn = ""
    assert_not @book.valid?

    @book.cover = ""
    assert_not @book.valid?
  end

  test "should enforce unique ISBN" do
    @book.save
    duplicate_book = @book.dup
    assert_not duplicate_book.valid?
  end

  test "should check availability" do
    assert @book.available?
    @book.save
    user = User.create(email_address: "user@example.com", password: "password")
    @book.borrowings.create(user: user, returned: false)
    assert_not @book.available?
  end
end
