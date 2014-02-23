class AddAuthorIdToVote < ActiveRecord::Migration
  def change
    add_column :votes, :author_id, :integer
  end
end
