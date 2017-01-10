class CreateSurveyAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_areas do |t|
      t.string :name

      t.timestamps
    end
  end
end
