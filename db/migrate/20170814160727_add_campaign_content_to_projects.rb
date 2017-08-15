class AddCampaignContentToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :campaign_content, :text
  end
end
