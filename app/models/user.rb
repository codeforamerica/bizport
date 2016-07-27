class User < ActiveRecord::Base
  has_many :accomplishments
  has_many :checklist_items, through: :accomplishments

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    role == 'admin'
  end
end
