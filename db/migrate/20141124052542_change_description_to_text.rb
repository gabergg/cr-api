class ChangeDescriptionToText < ActiveRecord::Migration
  def change
    change_column :beans, :description, :text, :limit => nil
  end
end
