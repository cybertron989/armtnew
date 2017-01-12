class SurveysController < ApplicationController
  def index
  end

  def new
  	@surveys = Survey.records params[:user_id] || "C225202"
  end

  def create
  	params[:surveys].each do |survey_area, user_survey|
  		user_survey[:survey_questions].each do |id, response|
  			survey = Survey.find_by(id: id)
  			survey.status = :completed
        survey.survey_response = response
        survey.dou = user_survey[:DOU] #if response == "true"      
  			survey.save
      end
    end
    redirect_to completed_page_surveys_path  	
  end

  def get_dous
    @dous = Dou.where(survey_area: params[:survey_area])
  end
end
