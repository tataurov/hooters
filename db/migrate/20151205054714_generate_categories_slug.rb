class GenerateCategoriesSlug < ActiveRecord::Migration
  def change
  end

  def migrate(direction)
    super

    # Generate slugs
    if direction == :up && !Rails.env.test?
      Category.all.each do |category|
        category.save!
      end
    end
  end
end
