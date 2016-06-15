class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.datetime :time_started
      t.integer :prev_quantity_active
      t.integer :current_quantity_active
      t.integer :total_time

      t.timestamps null: false
    end
  end
end
