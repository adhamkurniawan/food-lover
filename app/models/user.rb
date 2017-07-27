class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes

  def full_name
    return "#{first_name} #{last_name}".empty? ? "#{email}" : "#{first_name} #{last_name}"
  end
end
