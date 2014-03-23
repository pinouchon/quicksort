class AddAuthorIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :target_user_id, :integer
  end
end
