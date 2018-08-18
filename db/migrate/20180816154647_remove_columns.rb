class RemoveColumns < ActiveRecord::Migration[5.2]
  def change
      remove_column :charging_points, :place_id
  end
end
