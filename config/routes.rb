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


 

  
  scope module: :public do
   # ゲストログイン用
   resources :users, only: [ :create, :index, :show, :edit, :destroy, :update] do
    resource :followers,only: [:index,:create, :destroy]
   end
  
   post 'users/guest_sign_in', to: 'users#guest_sign_in'
   get "/about" => "homes#about", as: "about"
    root to: 'homes#top'
   get "search" => "searches#search"
   
   
   get "/followers/following"=> "followers#followings"
   get "/followers/followed"=> "followers#followed"
   
   resources :posts do
   resources :comments, only: [:create, :destroy]
   resource :likes, only: [:create, :destroy]
  
  end
   
  end
  
  scope module: :admin do
  get "admin/users"=>"users#index"
  end
   
    namespace :admin do
      root to: 'homes#top'
    end
end