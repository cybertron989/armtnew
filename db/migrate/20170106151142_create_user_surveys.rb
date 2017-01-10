class CreateUserSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :user_surveys do |t|
      t.string :user_id, null: false
      t.string :survey_type, null: false
      t.string :area, null: false
      t.string :schema_area, null: false
      t.string :environment
      t.boolean :response, null: false
      t.string :dou

      t.timestamps
    end
  end
end
