class AddDescriptionColumnToBeans < ActiveRecord::Migration
  def change
    add_column :beans, :description, :string
  end
end
