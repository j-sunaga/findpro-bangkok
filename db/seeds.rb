require 'csv'

# カテゴリ(category)
Category.create!(name: 'Translate')
Category.create!(name: 'Tour Guide')
Category.create!(name: 'HouseWork')
Category.create!(name: 'Driving')
Category.create!(name: 'Sports')

# 投稿者(recruiter)
CSV.foreach('db/csv/recruiter.csv', headers: true) do |row|
  recruiter = User.create(
    name: row['name'],
    content: Faker::Quote.most_interesting_man_in_the_world,
    email: row['email'],
    applicant_or_recruiter: 'recruiter',
    profile_image: open("./db/fixtures/user_#{rand(1..5)}.jpg"),
    admin: false,
    password: '123456'
  )
  category = Category.where('id >= ?', rand(Category.first.id..Category.last.id)).first
  post = Post.create!(
    title: row['title'],
    detail: Faker::Quote.most_interesting_man_in_the_world,
    deadline: Faker::Time.between(from: DateTime.now, to: DateTime.now + 14),
    post_image: open("./db/fixtures/post_#{rand(1..5)}.jpg"),
    status: 'open',
    recruiter_id: recruiter.id
  )
  CategoryPost.create!(category_id: category.id, post_id: post.id)
end

# 応募者(applicant)
CSV.foreach('db/csv/applicant.csv', headers: true) do |row|
  applicant = User.create(
    name: row['name'],
    content: Faker::Quote.most_interesting_man_in_the_world,
    email: row['email'],
    applicant_or_recruiter: 'applicant',
    profile_image: open("./db/fixtures/user_#{rand(1..5)}.jpg"),
    admin: false,
    password: '123456'
  )
  category = Category.where('id >= ?', rand(Category.first.id..Category.last.id)).first
  CategoryUser.create!(user_id: applicant.id, category_id: category.id)
end

## ブックマーク(bookmark)
20.times do |_n|
  applicant = User.where('id >= ?', rand(User.applicants.first.id..User.applicants.last.id)).first
  post = Post.where('id >= ?', rand(Post.first.id..Post.last.id)).first
  Bookmark.create!(user_id: applicant.id, post_id: post.id)
end

## 応募(application)
20.times do |_n|
  applicant = User.where('id >= ?', rand(User.applicants.first.id..User.applicants.last.id)).first
  post = Post.where('id >= ?', rand(Post.first.id..Post.last.id)).first
  Application.create!(
    user_id: applicant.id,
    post_id: post.id
  )
end

## メッセージ(message)
20.times do |_n|
  applicant = User.where('id >= ?', rand(User.applicants.first.id..User.applicants.last.id)).first
  recruiter = User.where('id >= ?', rand(User.recruiters.first.id..User.recruiters.last.id)).first
  conversation = Conversation.create!(
    sender_id: applicant.id,
    recipient_id: recruiter.id
  )
  Message.create!(
    user_id: applicant.id,
    conversation_id: conversation.id,
    body: Faker::Quote.most_interesting_man_in_the_world
  )
  Message.create!(
    user_id: recruiter.id,
    conversation_id: conversation.id,
    body: Faker::Quote.most_interesting_man_in_the_world
  )
end

## コメント(comment)
20.times do |_n|
  applicant = User.where('id >= ?', rand(User.applicants.first.id..User.applicants.last.id)).first
  post = Post.where('id >= ?', rand(Post.first.id..Post.last.id)).first
  Comment.create!(
    content: Faker::Quote.most_interesting_man_in_the_world,
    user_id: applicant.id,
    post_id: post.id
  )
end

## 応募者選択(select_user)
5.times do |_n|
  applicant = User.where('id >= ?', rand(User.applicants.first.id..User.applicants.last.id)).first
  post = Post.where('id >= ?', rand(Post.first.id..Post.last.id)).first
  post.update!(
    selected_user_id: applicant.id,
    status: 'closed'
  )
end
