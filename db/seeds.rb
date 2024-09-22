puts "Start inserting seed data"
user1 = User.find_or_initialize_by(nickname: "Alice", email: "alice@example.com")
user1.password = "password"
puts user1.save ? "User1 created" : "User1 creation failed"

user2 = User.find_or_initialize_by(nickname: "Bob", email: "bob@example.com")
user2.password = "password"
puts user2.save ? "User2 created" : "User2 creation failed"

tag_array = %w[Ruby Rails JavaScript TypeScript React ハンバーグ ラーメン カレー ピザ パスタ]

10.times do
  user1.posts.create!(title: Faker::Book.title, content: Faker::Markdown.sandwich(sentences: 10, repeat: 10), tag_list: tag_array.sample(3).join(" "))
end

10.times do
  user2.posts.create!(title: Faker::Book.title, content: Faker::Markdown.sandwich(sentences: 10, repeat: 10), tag_list: tag_array.sample(3).join(" "))
end
