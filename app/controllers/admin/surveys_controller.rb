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

	def email_notification
		
	end

	def set_email_notifications
		params[:reminders] && params[:reminders].each_with_index do |reminder, index|
		  duration = Time.strptime(reminder, "%m/%d/%Y") - Time.now
      subject = case index
					      	when 0
					      		params[:subject]
					      	when params[:reminders].length
					      		"Last Reminder: #{params[:subject]}"
					      	else
					      		"Re: #{params[:subject]}"
					      end

      SurveyNotificationWorker.perform_in(duration, subject, params[:body])
	  end
    redirect_to email_notification_admin_surveys_path, :flash => { :success => I18n.t(:success_email_notification) }
	end

	def export_excel
		user_surveys = UserSurveysDatatable.new(view_context) 
		@data =  user_surveys.as_excel
	  respond_to do |format| 
	  	format.xlsx {
		    response.headers['Content-Disposition'] = 'attachment; filename="armt_survey.xlsx"'
		  }
    end
	end


end
