class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :campaign_id
      t.text :description

      t.timestamps
    end
  end
end
