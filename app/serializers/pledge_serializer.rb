class PledgeSerializer < ActiveModel::Serializer
  attributes :id, :amount, :created_at, :project_id
  belongs_to :user
end
