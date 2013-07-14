class AddHrefToLink < ActiveRecord::Migration
  def change
    add_column :links, :href, :string
  end
end
