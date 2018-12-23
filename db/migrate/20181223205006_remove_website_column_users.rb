class RemoveWebsiteColumnUsers < ActiveRecord::Migration
  def change
    remove_column(:users, :website)
  end
end
