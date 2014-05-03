resources :tasks, :only => [:index, :create, :destroy, :feed] do
  collection { get :feed }
  member { get :done }
end

