class AddPriceColumn < ActiveRecord::Migration
  def change
    add_column :beans, :price, :string
  end
end
