class AddIndexToUnits < ActiveRecord::Migration
  def change
    add_index :units, :short_name, unique: true
  end
end
