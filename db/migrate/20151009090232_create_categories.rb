class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.string :slug, index: true
      t.string :link, index: true
      t.timestamps
    end
  end
end
