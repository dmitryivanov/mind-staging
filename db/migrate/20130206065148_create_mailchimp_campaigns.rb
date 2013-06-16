class CreateMailchimpCampaigns < ActiveRecord::Migration
  def change
    create_table :mailchimp_campaigns do |t|
      t.string :mailchimp_id
      t.string :title
      t.integer :syntax_errors
      t.integer :hard_bounces
      t.integer :soft_bounces
      t.integer :unsubscribes
      t.integer :abuse_reports
      t.integer :forwards
      t.integer :forwards_opens
      t.integer :opens
      t.timestamp :last_open
      t.integer :unique_opens
      t.integer :clicks
      t.integer :unique_clicks
      t.integer :users_who_clicked
      t.timestamp :last_click
      t.integer :emails_sent
      t.integer :unique_likes
      t.integer :recipient_likes
      t.integer :facebook_likes

      t.timestamps
    end
  end
end
