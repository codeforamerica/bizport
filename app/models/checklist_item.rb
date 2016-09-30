class ChecklistItem < ApplicationRecord
  has_many :accomplishments, dependent: :destroy
  has_many :users, through: :accomplishments
end
