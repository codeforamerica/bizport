FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :user_admin, parent: :user do
    role 'admin'
  end
end
