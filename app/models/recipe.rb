class Recipe < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  acts_as_votable
  #searchkick

  belongs_to :user
  has_many :ingredients
  has_many :directions
  belongs_to :category

  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true

  validates :title, :description, :image, presence: true
  has_attached_file :image, styles: { medium: "400x400#", thumb: "100x100>" }, :storage => :cloudinary, :path => "food-lover/recipes/:filename"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
