class AddGirls < ActiveRecord::Migration
  def change
    create_table :girls do |t|
      t.string :name, index: true
      t.timestamps
    end
  end
end
