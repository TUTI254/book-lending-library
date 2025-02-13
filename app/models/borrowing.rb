class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, uniqueness: { scope: :book_id, message: "has already borrowed this book" }

  before_create :set_due_date

  private

  def set_due_date
    self.due_date ||= 2.weeks.from_now
  end
end
