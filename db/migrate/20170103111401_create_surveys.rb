class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.string :user_id, null: false
      t.string :survey_type, null: false
      t.string :area, null: false
      t.string :schema_area, null: false
      t.string :environment
      t.integer :status

      t.timestamps
    end
  end
end
