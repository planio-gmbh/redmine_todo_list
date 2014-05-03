require 'redmine'

Rails.configuration.to_prepare do
  User.send(:include, RedmineTodoList::UserPatch) unless User.included_modules.include? RedmineTodoList::UserPatch
end

Redmine::Plugin.register :redmine_todo_list do
  name 'Redmine Task List plugin'
  author 'Brandon Farmer and Josh Thomas'
  description 'Allows you to maintain a personal todo list'
  version '0.0.1'
  requires_redmine :version_or_higher => '2.3.0'

  menu :top_menu, :todo_list,
    {:controller => 'tasks', :action => 'index'},
    :caption => Proc.new {User.current.tasks_top_menu},
    :if => Proc.new { User.current.logged? }
end
