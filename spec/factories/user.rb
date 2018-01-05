FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :user_admin, parent: :user do
    role 'admin'
  end

  factory :user_with_custom_checklist_items, parent: :user do
    transient do
      custom_checklist_items_count 5
    end
    after(:build) do |user, evaluator|
      user.custom_checklist_items << build_list(:checklist_item, evaluator.custom_checklist_items_count, created_by_user_id: user.id)
    end
  end
end
