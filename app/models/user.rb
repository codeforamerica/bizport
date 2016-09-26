class User < ActiveRecord::Base
  has_many :accomplishments
  has_many :checklist_items, through: :accomplishments
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
end
