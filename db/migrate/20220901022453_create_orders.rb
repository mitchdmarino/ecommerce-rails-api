class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    create_table :orders_products, id: false do |t|
      t.belongs_to :product, index: true
      t.belongs_to :order, index: true
    end
  end
end
