class ChecklistItem < ApplicationRecord
  has_many :accomplishments
  has_many :users, through: :accomplishments
end
