class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    t.string :name
    t.string :email
    t.string :password_digest
    t.text :mentor_description
    t.string :website
    t.string :linked_in
    t.string :location
    end
  end
end
