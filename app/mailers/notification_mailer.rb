class NotificationMailer < ApplicationMailer

	def send_survey_email body, subject, user
		@user = user
		@body = body
    @url  = 'http://example.com/login'
    mail(to: "puneet.agrawal1@tcs.com", subject: subject)
	end
end
