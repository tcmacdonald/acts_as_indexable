class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :title
      t.string :email
      t.text :body
      t.decimal :price, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
