class AddReputationToUser < ActiveRecord::Migration
  def up
    add_column :users, :reputation, :integer, default: 0
  end

  def down

  end
end
