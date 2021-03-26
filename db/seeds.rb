# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1000.times do |n|
  comments = Array.new(1 + rand(10)) do |m|
    Comment.new(author: "Test Author", text: "Comment #{m}")
  end

  article = Article.create(
    title: "Article #{n}",
    body: "Body #{n}",
    comments: comments
  )

  unless article.valid?
    puts article.errors.full_messages.join(',')
  end
end