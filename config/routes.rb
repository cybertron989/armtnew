Rails.application.routes.draw do

  namespace :admin do
    get 'dashboards' => "dashboards#index"
    resources :surveys do
    	collection do
    	  get "user_surveys"
        get "email_notification"
        post "set_email_notifications"
    	end
    end
  end

	resources :surveys do
    collection do
      get "get_dous"
    end
  end
	root "home#index"

end
