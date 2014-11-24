class AddBeansTable < ActiveRecord::Migration
  def change
    create_table :beans do |t|

      t.string :name
      t.string :roaster
      t.string :roast
      t.string :origin
      t.string :location
      t.date :review_date
      t.integer :overall_rating
      t.integer :aroma
      t.integer :acidity
      t.integer :body
      t.integer :flavor
      t.integer :aftertaste

      t.timestamps
    end

    add_index :beans, :roaster
    add_index :beans, :roast
    add_index :beans, :origin
    add_index :beans, :review_date
    add_index :beans, :location
    add_index :beans, :overall_rating
  end
end
