Rails.application.routes.draw do
# 会員用
# URL /users/sign_in
devise_for :users,skip: [:passwords], controllers: {
  #会員登録
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


#get 'fishes/new'

resources :users, only: [ :create, :index, :show, :edit, :destroy, :update]

  scope module: :public do
   root to: 'homes#top'
   get "/about"=>"homes#about"
  end
   
    namespace :admin do
      root to: 'homes#top'
    end
end