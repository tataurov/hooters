class AddSlugToGirls < ActiveRecord::Migration
  def change
    change_table :girls do |t|
      t.column :slug, :string
    end
  end

  def migrate(direction)
    super

    # Generate slugs
    if direction == :up && !Rails.env.test?
      Girl.all.each do |girl|
        girl.save!
      end
    end
  end

end
