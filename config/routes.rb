Rails.application.routes.draw do

  namespace :admin do
    get 'dashboards' => "dashboards#index"
    resources :surveys do
    	collection do
        get "user_surveys"
    	  get "export_excel"
        get "email_notification"
        get "show_data"
        post "set_email_notifications"
        post "save_data"
    	end
    end
  end

	resources :surveys do
    collection do
      get "get_dous"
      get "completed_page"
    end
  end
	root "home#index"

end
