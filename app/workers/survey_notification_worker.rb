class SurveyNotificationWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    users = Survey.active.pluck(:user_id).uniq
    users.each do |user|
    	NotificationMailer.send_survey_email(args[0], args[1], user).deliver_now
    end
  end
end
