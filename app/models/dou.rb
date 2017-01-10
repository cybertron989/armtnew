class Dou < ApplicationRecord
	validates :survey_area, inclusion: { in: SurveyArea.pluck(:name),   message: "%{value} is not a valid area" }
end
