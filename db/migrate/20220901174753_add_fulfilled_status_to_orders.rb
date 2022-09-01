class AddFulfilledStatusToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :fulfilled, :boolean, :default => false
  end
end
