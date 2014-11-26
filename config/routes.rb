# == Route Map (Updated 2014-08-18 18:54)
#
#                     root        /                                      home#index
#         new_user_session GET    /users/sign_in(.:format)               devise/sessions#new
#             user_session POST   /users/sign_in(.:format)               devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)              devise/sessions#destroy
#            user_password POST   /users/password(.:format)              devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)          devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)         devise/passwords#edit
#                          PUT    /users/password(.:format)              devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                devise/registrations#cancel
#        user_registration POST   /users(.:format)                       devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)               devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                  devise/registrations#edit
#                          PUT    /users(.:format)                       devise/registrations#update
#                          DELETE /users(.:format)                       devise/registrations#destroy
#                    users GET    /users(.:format)                       users#index
#                          POST   /users(.:format)                       users#create
#                 new_user GET    /users/new(.:format)                   users#new
#                edit_user GET    /users/:id/edit(.:format)              users#edit
#                     user GET    /users/:id(.:format)                   users#show
#                          PUT    /users/:id(.:format)                   users#update
#                          DELETE /users/:id(.:format)                   users#destroy
#                 orgtrees GET    /orgtrees(.:format)                    orgtrees#index
#                          POST   /orgtrees(.:format)                    orgtrees#create
#              new_orgtree GET    /orgtrees/new(.:format)                orgtrees#new
#             edit_orgtree GET    /orgtrees/:id/edit(.:format)           orgtrees#edit
#                  orgtree GET    /orgtrees/:id(.:format)                orgtrees#show
#                          PUT    /orgtrees/:id(.:format)                orgtrees#update
#                          DELETE /orgtrees/:id(.:format)                orgtrees#destroy
#                uploaders GET    /uploaders(.:format)                   uploaders#index
#                          POST   /uploaders(.:format)                   uploaders#create
#             new_uploader GET    /uploaders/new(.:format)               uploaders#new
#            edit_uploader GET    /uploaders/:id/edit(.:format)          uploaders#edit
#                 uploader GET    /uploaders/:id(.:format)               uploaders#show
#                          PUT    /uploaders/:id(.:format)               uploaders#update
#                          DELETE /uploaders/:id(.:format)               uploaders#destroy
#                  folders GET    /folders(.:format)                     folders#index
#                          POST   /folders(.:format)                     folders#create
#               new_folder GET    /folders/new(.:format)                 folders#new
#              edit_folder GET    /folders/:id/edit(.:format)            folders#edit
#                   folder GET    /folders/:id(.:format)                 folders#show
#                          PUT    /folders/:id(.:format)                 folders#update
#                          DELETE /folders/:id(.:format)                 folders#destroy
#   download_file_uploader GET    /uploaders/:id/download_file(.:format) uploaders#download_file
#                          GET    /uploaders(.:format)                   uploaders#index
#                          POST   /uploaders(.:format)                   uploaders#create
#                          GET    /uploaders/new(.:format)               uploaders#new
#                          GET    /uploaders/:id/edit(.:format)          uploaders#edit
#                          GET    /uploaders/:id(.:format)               uploaders#show
#                          PUT    /uploaders/:id(.:format)               uploaders#update
#                          DELETE /uploaders/:id(.:format)               uploaders#destroy
#             download_all GET    /download_all(.:format)                uploaders#download_all
#                   search GET    /search(.:format)                      uploaders#search
#               orgdiagram GET    /orgdiagram(.:format)                  home#orgdiagram
#                     home GET    /home(.:format)                        :controller#:action
#                   signin GET    /signin(.:format)                      :controller#:action
#               add_attach POST   /add_attach(.:format)                  uploaders#add_attach
#                          POST   /new_folder(.:format)                  folders#new_folder
#                  manager GET    /manager(.:format)                     folders#manager_view
#                 explorer GET    /explorer(.:format)                    folders#explorer_view
#                    blank GET    /blank(.:format)                       home#blank
#                  buttons GET    /buttons(.:format)                     home#buttons
#                     flot GET    /flot(.:format)                        home#flot
#                    forms GET    /forms(.:format)                       home#forms
#                     grid GET    /grid(.:format)                        home#grid
#                  example GET    /example(.:format)                     home#example
#                    login GET    /login(.:format)                       home#login
#            notifications GET    /notifications(.:format)               home#notifications
#                   panels GET    /panels(.:format)                      home#panels
#                   tables GET    /tables(.:format)                      home#tables
#               typography GET    /typography(.:format)                  home#typography
#                                 /*path(.:format)                       :controller#:action
#

PortalCTO::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end

  root :to => 'home#index'

  devise_for :users
  resources :users
  resources :orgtrees
  resources :uploaders
  resources :folders

  resources :uploaders do
    member do
      get :download_file
    end
  end

  get "/download_all", :to => 'uploaders#download_all'
  get '/search', :to => "uploaders#search"
  get 'orgdiagram', :to => "home#orgdiagram"
  get '/home', to: redirect('/')
  get '/signin', to:  redirect('/users/sign_in')

  post '/add_attach', :to => 'uploaders#add_attach'
  post "/new_folder", :to => 'folders#new_folder'
  get '/manager', :to => "folders#manager_view"
  get '/explorer', :to => "folders#explorer_view"

  get '/blank'         , :to => 'home#blank'
  get '/buttons'       , :to => 'home#buttons'
  get '/flot'          , :to => 'home#flot'
  get '/forms'         , :to => 'home#forms'
  get '/grid'          , :to => 'home#grid'
  get '/example'       , :to => 'home#example'
  get '/login'         , :to => 'home#login'
  get '/notifications' , :to => 'home#notifications'
  get '/panels'        , :to => 'home#panels'
  get '/tables'        , :to => 'home#tables'
  get '/typography'    , :to => 'home#typography'

  match '*path' => redirect('/')  #unless Rails.env.development?
end
