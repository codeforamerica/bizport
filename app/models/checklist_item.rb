class ChecklistItem < ApplicationRecord
  has_many :accomplishments, dependent: :destroy
  has_many :users, through: :accomplishments

  attr_accessor :completed
  attr_accessor :disabled

  def attributes
    super.merge(completed: self.completed, disabled: self.disabled)
  end

  def with_state_for_user(user)
    self.completed = accomplishments.where(completed: true, user: user).any?
    self.disabled = accomplishments.where(disabled: true, user: user).any?
    self
  end
end
