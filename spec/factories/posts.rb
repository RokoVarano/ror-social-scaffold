FactoryBot.define do
  factory :post do
    id { 1 }
    user_id { 1 }
    content { 'MyText' }
    created_at { '2021-03-26 14:17:58' }
    updated_at { '2021-03-26 14:17:58' }
  end
end
