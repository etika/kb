class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.text :message
      t.integer :category_id

      t.timestamps
    end
  end
end
