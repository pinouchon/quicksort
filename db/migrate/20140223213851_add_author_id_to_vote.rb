class AddAuthorIdToVote < ActiveRecord::Migration
  def change
    add_column :votes, :target_user_id, :integer
  end
end
