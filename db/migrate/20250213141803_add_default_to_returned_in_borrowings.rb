class AddDefaultToReturnedInBorrowings < ActiveRecord::Migration[7.0]
  def change
    change_column_default :borrowings, :returned, false
    Borrowing.where(returned: nil).update_all(returned: false)
  end
end
