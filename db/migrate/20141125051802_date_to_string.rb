class DateToString < ActiveRecord::Migration
  def change
    change_column :beans, :review_date, :string
  end
end
