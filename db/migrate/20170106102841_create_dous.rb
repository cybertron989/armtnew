class CreateDous < ActiveRecord::Migration[5.0]
  def change
    create_table :dous do |t|
      t.string :name
      t.string :team_name
      t.string :survey_area

      t.timestamps
    end
  end
end
