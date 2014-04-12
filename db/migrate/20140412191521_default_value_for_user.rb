class DefaultValueForUser < ActiveRecord::Migration
  def up
    change_column :users, :checked_reputation_at, :datetime, default: '2010-01-01 00:00:00'
    change_column :users, :checked_replies_at, :datetime, default: '2010-01-01 00:00:00'
  end

  def down
  end
end
