class CreateBeans < ActiveRecord::Migration
  def change
    create_table :beans do |t|

      t.timestamps
    end
  end
end
