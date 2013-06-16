Egglogg::App.controllers :projects do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  before do
    @my_projects = Project.find(:all, :order => 'created_at desc')
  end
  
  get :index do
    @projects = Project.all(:order => 'created_at desc')
    render '/projects/index'
  end

  get :show, :with => :id do
    @project = Project.find_by_id(params[:id])
    render '/projects/show'
  end

end
