Egglogg::Admin.controllers :sessions do
  get :new do
    render "/sessions/new", nil, :layout => false
  end

  post :create do
    if account = Account.authenticate(params[:email], params[:password])
      set_current_account(account)
      redirect_back_or_default('/')
    elsif Padrino.env == :development && params[:bypass]
      account = Account.first
      set_current_account(account)
      redirect url(:base, :index)
    else
      params[:email], params[:password] = h(params[:email]), h(params[:password])
      flash[:error] = pat('login.error')
      #redirect url(:sessions, :new)
      redirect '/'
    end
  end

  delete :destroy do
    set_current_account(nil)
    redirect url(:sessions, :new)
  end
  
   get :logout do
    set_current_account(nil)
    redirect '/'
  end
end
