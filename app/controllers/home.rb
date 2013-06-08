Egglogg::App.controllers :home do

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


  get :index do
    render 'home/index'
  end

  get :about do
    render 'home/about'
  end

  get :contact do
    if(current_account.nil?)
      flash[:error] = 'You are not authorized.'
      redirect '/'
    end

    render 'home/contact'
  end

end
