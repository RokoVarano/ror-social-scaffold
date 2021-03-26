FactoryBot.define do
  factory :comment do
    id { 1 }
    user_id { 1 }
    post_id { 1 }
    content { "MyText" }
    created_at { "2021-03-26 14:17:56" }
    updated_at { "2021-03-26 14:17:56" }
  end
end
