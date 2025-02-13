require "test_helper"

class BorrowingTest < ActiveSupport::TestCase
  def setup
    @user = User.create(email_address: "user@example.com", password: "password")
    @book = Book.create(title: "Sample Book", author: "John Doe", isbn: "1234567890", cover: "cover_url")
    @borrowing = Borrowing.new(user: @user, book: @book)
  end

  test "should be valid" do
    assert @borrowing.valid?
  end

  test "should enforce unique borrowing per user-book pair" do
    @borrowing.save
    duplicate_borrowing = Borrowing.new(user: @user, book: @book)
    assert_not duplicate_borrowing.valid?
  end

  test "should set due date before creation" do
    @borrowing.save
    assert_not_nil @borrowing.due_date
  end
end
