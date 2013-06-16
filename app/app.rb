module Egglogg
  class App < Padrino::Application
    register SassInitializer
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    register Padrino::Admin::AccessControl
    register Padrino::Admin::Helpers

    enable :sessions
    set :session_id, "egglog-global-session"

    before do
      @recents = Post.find(:all, :order => 'created_at desc', :limit => 5)
    end

    access_control.roles_for :any do |role|
      role.protect '/posts'
      role.protect '/projects'
      role.allow   '/home'
    end
    
    access_control.roles_for :admin do |role|
      role.project_module :projects, '/projects'
      role.project_module :posts, '/posts'
    end
    
    access_control.roles_for :developer do |role|
      role.project_module :projects, '/projects'
      role.project_module :posts, '/posts'
    end
    
    access_control.roles_for :leader do |role|
      role.project_module :projects, '/projects'
      role.project_module :posts, '/posts'
    end
    
    # get /
    get "/" do
      render '/home/index'
    end

    get "/about" do
      render '/home/about'
    end

    get "/contact" do
      render '/home/contact'
    end

  end
end
