class Survey < ApplicationRecord
  
  enum status: [ :active, :completed, :archived, :deleted ]
  validates :user_id, :survey_type, :area, :schema_area, presence: true
  validates_uniqueness_of :user_id, scope: [:user_id, :survey_type, :area, :schema_area, :environment, :status], on: :create
  validates :survey_type, inclusion: { in: SurveyType.pluck(:name),   message: "%{value} is not a valid type" }
  validates :area, inclusion: { in: SurveyArea.pluck(:name),   message: "%{value} is not a valid area" }

  scope :active, -> { where(status: Survey.statuses[:active]) }
  
  after_update :save_user_survey, if: "self.survey_response.present?"
   
  SURVEY_ENVIRONMENT = ["Development", "Production", "Test" ]
  
  attr_accessor :survey_response, :dou
  
	def self.import file
		spreadsheet = Roo::Excelx.new(file.path)
		surveys = []
		survey_errors = []
	  (2..spreadsheet.last_row).each do |i|
	  	row= spreadsheet.row(i)
	    if row[0].present? && row[1].present?
	      survey = Survey.new(user_id: row[0], 
	     	                    survey_type: row[1],
	     	                    area: row[2], 
	     	                    schema_area: row[3].try(:upcase), 
	     	                    environment: row[4].try(:capitalize), 
	     	                    status:  Survey.statuses[:active]
	     	                  )
	      surveys << survey
	      survey_errors << {row: i, error_message: survey.errors.full_messages} unless survey.valid?
	    end
	  end
	  if survey_errors.blank?
	  	surveys.each do |survey|
	  		survey.save
	  	end		   
	  end
	  return survey_errors, "Invalid File"
	end

	def self.showData file
		puts "inside show_data #{file.path}"
		spreadsheet = Roo::Excelx.new(file.path)
		surveys = []
		survey_errors = []
	  (2..spreadsheet.last_row).each do |i|
	  	row= spreadsheet.row(i)
	    if row[0].present? && row[1].present?
	      survey = Survey.new(user_id: row[0], 
	     	                    survey_type: row[1],
	     	                    area: row[2], 
	     	                    schema_area: row[3].try(:upcase), 
	     	                    environment: row[4].try(:capitalize), 
	     	                    status:  Survey.statuses[:active]
	     	                  )
	      surveys << survey
	      survey_errors << {row: i, error_message: survey.errors.full_messages} unless survey.valid?
	      puts "survey_errors: #{survey_errors}"
	    end
	  end
	  return surveys
	end

	def self.records id
		surveys = Survey.active.where(user_id: id)
		survey_hsh = {}
		surveys.each do |survey|			
      get_survey_area_record survey_hsh[survey.area] || survey_hsh[survey.area]={}, survey
		end
		survey_hsh
	end

	def self.get_survey_area_record survey_area_hsh, survey
  	survey_area_hsh_key = "#{survey.environment}$@#{survey.survey_type}"
  	# unless survey_area_hsh.has_key? survey_area_hsh_key
   #    survey_area_hsh[survey_area_hsh_key] = []
   #  end
  	survey_area_hsh[survey_area_hsh_key] || survey_area_hsh[survey_area_hsh_key] = []
    survey_area_hsh[survey_area_hsh_key] << {id: survey.id, schema_area: survey.schema_area}
	end

	def save_user_survey
	  user_survey = UserSurvey.new(user_id: self.user_id, 
                                 survey_type: self.survey_type,
                                 area: self.area,
                                 schema_area: self.schema_area,
                                 environment: self.environment,
                                 response: self.survey_response,
                                 dou: self.dou)
	  user_survey.save!
	end

end
