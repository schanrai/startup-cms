class User < ActiveRecord::Base
  
  has_secure_password
  has_many :startup_profiles
  has_many :mentorships, class_name: "StartupProfile", foreign_key: :mentor_id, inverse_of: :mentor

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    User.all.find{|u| u.slug == slug}
  end


end
