class Category < ApplicationRecord
  has_many :projects

  def number_of_projects
    self.projects.count
  end
end
