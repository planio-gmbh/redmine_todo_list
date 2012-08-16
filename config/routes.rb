ActionController::Routing::Routes.draw do |map|
  map.resources :tasks, :only => [:index, :create, :feed],
                        :collection => { :feed => :get }
  map.connect 'tasks/:id/done', :controller => 'tasks', :action => 'destroy'
end

