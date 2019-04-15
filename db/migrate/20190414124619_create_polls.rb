class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.integer :user_id
      t.integer :admin_id
      t.boolean :status
      t.timestamps
    end
  end
end
