class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.integer :external_reference
      t.text :ad_decription
      t.string :status
      t.integer :job_id
    end
  end
end
