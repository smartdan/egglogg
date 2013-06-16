# Helper methods defined here can be accessed in any controller or view in the application

Egglogg::App.helpers do
# def simple_helper_method
#  ...
# end

 def access_denied
    # If we have a login_page we redirect the user
    if login_page
      redirect(login_page)
    # If no match we halt with 401
    else
      flash[:error] = "You don't have permission for this resource."
      redirect '/'
    end
  end
  
end
