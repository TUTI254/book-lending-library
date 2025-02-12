class Book < ApplicationRecord
    has_many :borrowings, dependent: :destroy

    validates :title, :author, :isbn, :cover, presence: true
    validates :isbn, uniqueness: true
end
