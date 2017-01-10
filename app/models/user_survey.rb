class UserSurvey < ApplicationRecord
	scope :survey_type_filter, -> (survey_type) { where(survey_type: survey_type) if survey_type.present?}
  scope :environment_filter, -> (environment) { where(environment: environment) if environment.present?}
  scope :survey_response_filter, -> (response) { response.present? && response=="true" ? where(response: true) : where(response: false) }
end
