class Accomplishment < ActiveRecord::Base
  belongs_to :user
  belongs_to :checklist_item

  validates :user, presence: true
  validates :checklist_item, presence: true
end
