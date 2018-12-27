class StartupProfile < ActiveRecord::Base
belongs_to :user
belongs_to :mentor, class_name: "User", inverse_of: :mentorships

validates :name, presence: true, uniqueness: true

end
