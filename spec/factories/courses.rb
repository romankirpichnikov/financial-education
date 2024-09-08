FactoryBot.define do
  factory :course do
    title { "Sample Course" }
    description { "Sample Description" }
    association :author
  end
end
