class User < ActiveRecord::Base
  has_many :accomplishments, dependent: :destroy
  has_many :checklist_items, through: :accomplishments
  has_many :custom_checklist_items, class_name: 'ChecklistItem', foreign_key: :created_by_user_id
  has_one :notebook

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    role == 'admin'
  end

  def get_notebook
    self.notebook || self.create_notebook!
  end

  def completed_checklist_items
    ChecklistItem.joins(:accomplishments)
      .where(accomplishments: { completed: true, user_id: id})
  end

  def disabled_checklist_items
    ChecklistItem.joins(:accomplishments)
      .where(accomplishments: { disabled: true, user_id: id})
  end

  def all_checklist_items
    ChecklistItem.where('created_by_user_id IS NULL or created_by_user_id = ?', id)
  end
end
