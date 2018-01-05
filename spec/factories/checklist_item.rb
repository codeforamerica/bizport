FactoryBot.define do
  factory :checklist_item do
    item_text { Faker::Lorem.sentence }
    category { ['networking','marketing','city_contracts'].sample }
  end
end
