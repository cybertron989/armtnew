class Admin::SurveysController < AdminController
	def create
		@survey_errors, msg = Survey.import(params[:file])
		if @survey_errors.blank?		  	
	    redirect_to admin_dashboards_path, :flash => { :success => I18n.t(:success_upload_file) }
	  else
	  	render "admin/dashboards/index"
	  end
	end

	def user_surveys
    respond_to do |format|
	    format.html
	    format.json { render json: UserSurveysDatatable.new(view_context) }
	  end
	end
end
