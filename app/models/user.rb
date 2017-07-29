class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes

  validates :first_name, :last_name, :email, presence: true

  def full_name
    name = "#{first_name} #{last_name}"

    return name
  end
end
