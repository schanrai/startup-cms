class CreateStartupProfiles < ActiveRecord::Migration
  def change
    create_table :startup_profiles do |t|
    t.string :name
    t.integer :user_id
    t.integer :mentor_id
    t.text :description
    t.integer :year_founded
    t.string :website
    t.string :stage
    t.string :help_needed
    end
  end
end
