class Admin::SurveysController < AdminController


	def create
		if params[:file].present? && File.extname(params[:file].path) == ".xlsx"
			@survey_errors, msg = Survey.import(params[:file])
			if @survey_errors.blank?		  	
		    redirect_to admin_dashboards_path, :flash => { :success => I18n.t(:success_upload_file) }
		  else
		  	render "admin/dashboards/index"
		  end
		else
			redirect_to admin_dashboards_path, :flash => { :error => I18n.t(:invalid_file_upload) }
		end
	end

	def user_surveys
    respond_to do |format|
	    format.html
	    format.json { render json: UserSurveysDatatable.new(view_context) }
	  end
	end

	def email_notification
		delayed_jobs = Delayed::Job.all
		@email_notification = {}
		if delayed_jobs.present?
	    parse_dj = YAML.parse(delayed_jobs.first.handler)
	    subject = parse_dj.children.last.children.last.children.first.value
	    body = parse_dj.children.last.children.last.children.last.value
	    reminders = delayed_jobs.pluck(:run_at)
	    @email_notification = {subject: subject, body: body, reminders: reminders}
	  end
	end

	def set_email_notifications
    Delayed::Job.destroy_all
		params[:reminders] && params[:reminders].each_with_index do |reminder, index|
		  # duration = Time.strptime(reminder, "%m/%d/%Y") - Time.now
		  duration = Time.strptime(reminder, "%m/%d/%Y")
      subject = case index
					      	when 0
					      		params[:subject]
					      	when params[:reminders].length
					      		"Last Reminder: #{params[:subject]}"
					      	else
					      		"Re: #{params[:subject]}"
					      end
      SurveyNotificationWorker.delay(run_at: duration).perform_job(subject, params[:body])
      # SurveyNotificationWorker.perform_in(duration, subject, params[:body])
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
