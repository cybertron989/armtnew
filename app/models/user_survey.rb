class UserSurvey < ApplicationRecord
	scope :survey_type_filter, -> (survey_type) { where(survey_type: survey_type) if survey_type.present?}
  scope :environment_filter, -> (environment) { where(environment: environment) if environment.present?}
  scope :survey_response_filter, -> (response) { response=="true" ? where(response: true) : where(response: false) if  response.present? }

  TableColumn = %w[user_id survey_type schema_area environment response dou created_at]
  TableColumnShow = ["UserId", "SurveyType", "Schema Area", "Environment", "Response", "DOU", "Created At"]
  
end
