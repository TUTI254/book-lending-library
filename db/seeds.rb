books = [
  { title: "The Great Gatsby", author: "F. Scott Fitzgerald", isbn: "9780743273565", cover: "https://m.media-amazon.com/images/I/412LAX6QMML._SY445_SX342_.jpg" },
  { title: "1984", author: "George Orwell", isbn: "9780451524935", cover: "https://cdnattic.atticbooks.co.ke/img/F763507.jpg" },
  { title: "Pride and Prejudice", author: "Jane Austen", isbn: "9781503290563", cover: "https://m.media-amazon.com/images/I/61H3BvN-naL._SY342_.jpg" },
  { title: "Moby-Dick", author: "Herman Melville", isbn: "9781503280786", cover: "https://m.media-amazon.com/images/I/51HfDxpGT+L._SY445_SX342_.jpg" },
  { title: "War and Peace", author: "Leo Tolstoy", isbn: "9781420954306", cover: "https://m.media-amazon.com/images/I/41wJA+zum7L._SY445_SX342_.jpg" },
  { title: "Crime and Punishment", author: "Fyodor Dostoevsky", isbn: "9780486415871", cover: "https://m.media-amazon.com/images/I/71O2XIytdqL._SY342_.jpg" },
  { title: "Brave New World", author: "Aldous Huxley", isbn: "9780060850524", cover: "https://m.media-amazon.com/images/I/71GNqqXuN3L._SY342_.jpg" },
  { title: "Wuthering Heights", author: "Emily Brontë", isbn: "9781505313103", cover: "https://m.media-amazon.com/images/I/91+S0B+HWSL._SY342_.jpg" },
  { title: "Jane Eyre", author: "Charlotte Brontë", isbn: "9781503278190", cover: "https://m.media-amazon.com/images/I/81pwJjgcwwL._SY342_.jpg" },
  { title: "The Hobbit", author: "J.R.R. Tolkien", isbn: "9780345339683", cover: "https://m.media-amazon.com/images/I/418jD+Rsd5L._SY445_SX342_.jpg" },
  { title: "Les Misérables", author: "Victor Hugo", isbn: "9780451419439", cover: "https://m.media-amazon.com/images/I/51JgwXw3M4L._SY445_SX342_.jpg" },
  { title: "Dracula", author: "Bram Stoker", isbn: "9780486411095", cover: "https://m.media-amazon.com/images/I/5126hLd7jsL._SY445_SX342_.jpg" },
  { title: "Frankenstein", author: "Mary Shelley", isbn: "9780486282114", cover: "https://m.media-amazon.com/images/I/414fQLzXJiL._SY445_SX342_.jpg" }
]

books.each do |book|
  Book.find_or_create_by!(isbn: book[:isbn]) do |b|
    b.title = book[:title]
    b.author = book[:author]
    b.cover = book[:cover]
  end
end

users = [
  { email_address: "john@example.com", password: "password", password_confirmation: "password" },
  { email_address: "jane@example.com", password: "password", password_confirmation: "password" },
  { email_address: "luke@example.com", password: "password", password_confirmation: "password" },
  { email_address: "lisa@example.com", password: "password", password_confirmation: "password" },
  { email_address: "mark@example.com", password: "password", password_confirmation: "password" }
]

users.each do |user|
    User.find_or_create_by!(email_address: user[:email_address]) do |u|
      u.password = user[:password]
      u.password_confirmation = user[:password_confirmation]
    end
end

# Assign books to 3 users
borrowers = User.limit(3) # Selecting 3 users
borrowers.each do |user|
book = Book.order("RANDOM()").first # Pick a random book
Borrowing.create!(user: user, book: book, returned: false)
end

puts "Seed data created successfully!"
