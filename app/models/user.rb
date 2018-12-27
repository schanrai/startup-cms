class User < ActiveRecord::Base

  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :startup_profiles
  has_many :mentorships, class_name: "StartupProfile", foreign_key: :mentor_id, inverse_of: :mentor



end
