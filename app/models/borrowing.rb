class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  before_create :set_due_date

  private

  def set_due_date
    self.due_date = Date.today + 14.days
  end
end
