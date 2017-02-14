class Admin::SurveysController < AdminController

$file_data=[]
	def create
		if params[:file].present? && File.extname(params[:file].path) == ".xlsx"
		  			$file_data = Survey.showData(params[:file])
		    		redirect_to show_data_admin_surveys_path
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

	def show_data
	end

	def save_data
		surveys = []
		@survey_errors = []
		i=0;
		if  $file_data.present?
			$file_data.each do |data|
				puts "outside if #{params["value_#{i}"]}"
				if(params["value_#{i}"].present? && params["value_#{i}"]==i.to_s)
					puts " inside if value_#{i}: #{params["value_#{i}"]}"
					survey = Survey.new(user_id: data[:user_id], 
	     	                    survey_type: data[:survey_type],
	     	                    area: data[:area], 
	     	                    schema_area: data[:schema_area].try(:upcase), 
	     	                    environment: data[:environment].try(:capitalize), 
	     	                    status:  Survey.statuses[:active]
	     	                  )
	      			surveys << survey
	      			@survey_errors << {row: i, error_message: survey.errors.full_messages} unless survey.valid?
				end
				i=i+1
			end
		end
		if @survey_errors.blank? 
		 	if surveys.any?
				surveys.each do |survey|
	  				survey.save
	  			end	
	  			redirect_to admin_dashboards_path, :flash => { :success => I18n.t(:success_upload_file) }
			else
				redirect_to show_data_admin_surveys_path, :flash => { :error => I18n.t(:no_data_selected) }	
			end
		else
			render "admin/surveys/show_data"
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
