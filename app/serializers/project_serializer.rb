class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :funding_goal, :fund_by_date, :image, :campaign_content
  has_one :category
  belongs_to :creator, serializer: ProjectCreatorSerializer
  attribute :number_of_pledges
  attribute :number_of_backers
  attribute :percent_funded
  attribute :pledge_total
  attribute :days_left
end
