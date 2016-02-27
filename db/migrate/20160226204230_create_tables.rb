class CreateTables < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :portions
      t.text :cooking
      t.integer :duration
      t.belongs_to :user, index:true
      t.timestamps null: false
    end
    create_table :categories do |t|
      t.string :name, null: false
      t.string :description
      t.timestamps null: false
      t.index :name, unique: true
    end
    create_table :categories_recipes do |t|
      t.belongs_to :category, index: true
      t.belongs_to :recipe, index: true
      t.timestamps null: false
    end
    create_table :ingredients do |t|
      t.string :name, null: false
      t.string :description
      t.belongs_to :unit, index: true
      t.timestamps null: false
      t.index :name, unique: true
    end
    create_table :ingredients_recipes do |t|
      t.belongs_to :ingredient, index: true
      t.belongs_to :unit, index: true
      t.belongs_to :recipe, index: true
      t.decimal :amount, precision: 10, scale: 4, null: false
      t.string :note
      t.timestamps null: false
    end
    create_table :units do |t|
      t.string :short_name, null: false
      t.string :full_name
      t.timestamps null: false
    end
  end
end
