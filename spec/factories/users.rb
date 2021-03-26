FactoryBot.define do
  factory :user do
    id { 1 }
    email { "MyString" }
    encrypted_password { "MyString" }
    reset_password_token { "MyString" }
    reset_password_sent_at { "2021-03-26 14:17:54" }
    remember_created_at { "2021-03-26 14:17:54" }
    created_at { "2021-03-26 14:17:54" }
    updated_at { "2021-03-26 14:17:54" }
    name { "MyString" }
    gravatar_url { "MyString" }
  end
end
