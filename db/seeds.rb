require 'faker'

ActiveRecord::Base.connection.execute('TRUNCATE TABLE authors, courses, competencies, competencies_courses RESTART IDENTITY CASCADE;')
puts 'The tables have been cleared'

competencies = 10.times.map do
  Competency.create!(name: Faker::Educator.subject)
end

5.times do
  author = Author.create(name: Faker::Name.name)

  rand(2..5).times do
    course = Course.create(
      title: Faker::Educator.course_name,
      description: Faker::Lorem.paragraph(sentence_count: 5),
      author: author
    )

    course.competencies << competencies.sample(rand(1..3))
  end
end

puts "Seeding databse completed!"
