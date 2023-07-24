class AddForeignKeyToCartItem < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_items, :foreign_key_user_id, :integeir
  end
end
