class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def add_product(product)
    current_item = cart_items.find_by(product_id: product.id)
    
    if current_item
      current_item.increment(:quantity)
    else
      current_item = cart_item.build(product_id: product.id)
    end

  end

end
