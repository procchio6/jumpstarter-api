class User < ApplicationRecord
  has_secure_password
  has_many :created_projects, class_name: :Project
  has_many :pledges
  has_many :funded_projects, through: :pledges, source: :project

  validates :email, :username, uniqueness: true
  validates :first_name, :last_name, :username, :email, presence: true

  mount_base64_uploader :avatar, AvatarUploader

  def full_name
    "#{first_name} #{last_name}"
  end

  def number_of_pledges
    self.pledges.count
  end

  def pledge_total
    self.pledges.sum(:amount)
  end
end
