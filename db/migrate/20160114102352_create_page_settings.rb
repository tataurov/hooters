class CreatePageSettings < ActiveRecord::Migration
  def change
    create_table :page_settings do |t|
      t.string :controller, null: false
      t.string :action, null: false
      t.string :title
      t.string :keywords
      t.string :header
      t.text :description
      t.text :snippet

      t.timestamps
    end
    add_index :page_settings, [:controller, :action], :unique => true
  end
end
