class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :title
      t.string :email
      t.text :body

      t.timestamps null: false
    end
  end
end
