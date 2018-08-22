class RemoveRestaurantFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_reference :users, :restaurant, foreign_key: true
  end
end
