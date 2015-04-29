Pifa2013::Application.routes.draw do
    
    resources :press_releases

    devise_for :admins

    # MODALS
    get '/about/pics', :to => 'about#pifa_slideshow', :as => :pifa_pics_modal
    get '/streetfair/pics', :to => 'home#streetfair_slideshow', :as => :streetfair_pics_modal

    # ABOUT PAGES
    # OMFG make up your mind
    get '/press', :to => 'about#press', :as => :press
    get '/press/files', :to => 'about#press_protected', :as => :press_protected
    # get '/press', :to => 'about#press', :as => :press
    get '/more-info', :to => 'contacts#new', :as => :more_info
    get '/contact', :to => 'about#contact', :as => :contact
    get '/tickets', :to => 'about#tickets', :as => :about_tickets
    get '/privacy-policy', :to => 'about#privacy', :as => :privacy
    get '/supporters', :to => 'about#sponsors', :as => :sponsors
    get '/partners', :to => 'about#partners', :as => :partners
    get '/about', :to => 'about#index', :as => :about

    # CONTACT PAGES
    resources :contacts
    
    # MISC PAGES
    get '/plaza', :to => 'home#plaza', :as => :plaza
    get '/streetfair', :to => 'home#streetfair', :as => :streetfair
    get '/blog', :to => 'home#blog'
    get '/food-and-drink', :to => 'home#food_and_drink', :as => :food_and_drink

    # EVENTS
    get '/events/category/:id', :to => 'events#by_category', :as => :events_category
    get '/events/tag/:id', :to => 'events#by_tag', :as => :events_tag
    get '/events/date/:day', :to => 'events#by_day', :as => :events_day
    
    get '/api/1/category/free-feed', :to => 'events#free_feed', :as => :events_free_feed
    resources :events

    # ADMIN EVENTS CMS
    match '/admin/events/new', :to => 'admin_panel#new_event', :as => :admin_new_event
    match '/admin/events/:id/edit', :to => 'admin_panel#edit_event', :as => :admin_edit_event
    match '/admin/events/:id', :to => 'admin_panel#show_event', :as => :admin_show_event
    #post '/admin/events', :to => 'admin_panel#create_event', :as => :admin_create_event
    match '/admin/events', :to => 'admin_panel#events', :as => :admin_events
    match '/admin/sync', :to => 'admin_panel#tessitura_sync', :as => :tessitura_sync
    match '/admin', :to => 'admin_panel#events', :as => :admin

    # SEARCH
    match '/search', :to => 'home#search', :as => :search

    # PEFORMANCES CMS
    resources :performances

    # STORIES CMS
    resources :stories

    root :to => 'home#index'

end
