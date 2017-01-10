class CreateSurveyTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_types do |t|
      t.string :name
      t.boolean :has_environment, default: false

      t.timestamps
    end
  end
end
