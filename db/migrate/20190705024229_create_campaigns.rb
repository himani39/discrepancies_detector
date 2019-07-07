class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.integer :external_reference
      t.text :ad_description
      t.string :status
      t.integer :job_id
    end

    add_index(:campaigns, :external_reference, unique: true)
  end
end
