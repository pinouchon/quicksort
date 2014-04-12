class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :checked_reputation_at, :datetime
    add_column :users, :checked_replies_at, :datetime
  end
end
