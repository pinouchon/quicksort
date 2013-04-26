class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :description
      t.integer :topic_id

      t.timestamps
    end
  end
end
