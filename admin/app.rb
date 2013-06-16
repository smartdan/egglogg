module Egglogg
  class Admin < Padrino::Application
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl

    set :admin_model, 'Account'
    set :login_page,  '/admin/sessions/new'

    enable  :sessions
    disable :store_location
    set :session_id, "egglog-global-session" 

    access_control.roles_for :any do |role|
      role.protect '/'
      role.allow   '/sessions'
    end

    access_control.roles_for :admin do |role|
      role.project_module :tasks, '/tasks'
      role.project_module :projects, '/projects'
      role.project_module :posts, '/posts'
      role.project_module :accounts, '/accounts'
    end
    
    access_control.roles_for :leader do |role|
      role.project_module :tasks, '/tasks'
      role.project_module :projects, '/projects'
    end
    
    access_control.roles_for :developer do |role|
      role.project_module :tasks, '/tasks'
    end

    # Custom error management 
    error(403) { @title = "Error 403"; render('errors/403', :layout => :error) }
    error(404) { @title = "Error 404"; render('errors/404', :layout => :error) }
    error(500) { @title = "Error 500"; render('errors/500', :layout => :error) }
  end
end
