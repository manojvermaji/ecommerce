class Product < ApplicationRecord
  before_destroy :not_referenced_by_any_cart_item
  #validates :name, :desc, :price, presence :true
  validates :desc, length: {minimum:10, maximum:20}
  validates :price, numericality: {only_intger: true }, length: {maximum: 7}


  mount_uploader :image, ImageUploader
  serialize :image, JSON
  has_one_attached :image

  # def add_to_cart(cart)
  #   cart_item = cart.cart_items.find_by(product: self)

  #   if cart_item
  #     cart_item.quantity += 1
  #     cart_item.save
  #   else
  #     cart_item = cart.cart_items.build(product: self, quantity: 1)
  #     cart_item.save
  #   end
  # end


  has_many :cart_items
  belongs_to :user

  def not_referenced_by_any_cart_item
    unless cart_items.empty?
      error.add(:base, "Line items present")
      throw :abort
    end
  end


end
