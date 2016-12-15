class CreateJoinTableNodeProduct < ActiveRecord::Migration
  def change
    create_join_table :nodes, :products do |t|
      # t.index [:node_id, :product_id]
      # t.index [:product_id, :node_id]
    end
  end
end
