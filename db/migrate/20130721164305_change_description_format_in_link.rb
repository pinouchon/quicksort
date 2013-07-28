class ChangeDescriptionFormatInLink < ActiveRecord::Migration
  def self.up
    change_column :links, :description, :text
  end

  def self.down
    change_column :links, :description, :string
  end
end
