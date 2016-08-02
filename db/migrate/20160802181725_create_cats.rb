class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name, null: false
      t.date :birth_date, null: false
      t.string :color, null: false
      t.string :sex, limit: 1
      t.text :description
      t.timestamps null: false
    end
  end
end
