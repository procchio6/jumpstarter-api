class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :amount, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 1000}
  validates :user, presence: true
  validate :user_cannot_be_project_creator

  def user_cannot_be_project_creator
    if user == project.creator
      errors.add(:user, "can't pledge to own project")
    end
  end
end
