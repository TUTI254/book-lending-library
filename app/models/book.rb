class Book < ApplicationRecord
    validates :title, :author, :isbn, :cover, presence: true
    validates :isbn, uniqueness: true
end
