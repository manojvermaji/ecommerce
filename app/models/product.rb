class Product < ApplicationRecord
  #before_destroy :not_referenced_by_any_cart_item
  #validates :name, :desc, :price, presence :true
  validates :desc, length: {minimum:10, maximum:200}
  validates :price, numericality: {only_intger: true }, length: {maximum: 7}


  # mount_uploader :image, ImageUploader
  # serialize :image, JSON
  # has_one_attached :image

  


  has_many :cart_items
  belongs_to :user

  # def not_referenced_by_any_cart_item
  #   unless cart_items.empty?
  #     error.add(:base, "Line items present")
  #     throw :abort
  #   end
  # end


end
