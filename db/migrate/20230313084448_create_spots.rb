class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.string :memo
      t.integer :user_id

      t.timestamps
    end
  end
end
