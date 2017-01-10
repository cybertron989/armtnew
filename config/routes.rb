Rails.application.routes.draw do

  namespace :admin do
    get 'dashboards' => "dashboards#index"
    resources :surveys do
    	collection do
    	  get "user_surveys"
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
