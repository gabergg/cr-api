class AddAgtronAndWithMilk < ActiveRecord::Migration
  def change
    add_column :beans, :agtron, :string
    add_column :beans, :with_milk, :integer
  end
end
