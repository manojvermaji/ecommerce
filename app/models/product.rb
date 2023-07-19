class Product < ApplicationRecord
  #validates :name, :desc, :price, presence :true
  validates :desc, length: {minimum:10, maximum:20}
  validates :price, numericality: {only_intger: true }, length: {maximum: 7}


  mount_uploader :image, ImageUploader
  serialize :image, JSON
  has_one_attached :image
end
