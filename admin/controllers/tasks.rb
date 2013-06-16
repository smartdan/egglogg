Egglogg::Admin.controllers :tasks do
  get :index do
    @title = "Tasks"
    @tasks = Task.all
    render 'tasks/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'task')
    @task = Task.new
    render 'tasks/new'
  end

  post :create do
    @task = Task.new(params[:task])
    if @task.save
      @title = pat(:create_title, :model => "task #{@task.id}")
      flash[:success] = pat(:create_success, :model => 'Task')
      params[:save_and_continue] ? redirect(url(:tasks, :index)) : redirect(url(:tasks, :edit, :id => @task.id))
    else
      @title = pat(:create_title, :model => 'task')
      flash.now[:error] = pat(:create_error, :model => 'task')
      render 'tasks/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "task #{params[:id]}")
    @task = Task.find(params[:id])
    if @task
      render 'tasks/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'task', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "task #{params[:id]}")
    @task = Task.find(params[:id])
    if @task
      if @task.update_attributes(params[:task])
        flash[:success] = pat(:update_success, :model => 'Task', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:tasks, :index)) :
          redirect(url(:tasks, :edit, :id => @task.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'task')
        render 'tasks/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'task', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Tasks"
    task = Task.find(params[:id])
    if task
      if task.destroy
        flash[:success] = pat(:delete_success, :model => 'Task', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'task')
      end
      redirect url(:tasks, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'task', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Tasks"
    unless params[:task_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'task')
      redirect(url(:tasks, :index))
    end
    ids = params[:task_ids].split(',').map(&:strip).map(&:to_i)
    tasks = Task.find(ids)
    
    if Task.destroy tasks
    
      flash[:success] = pat(:destroy_many_success, :model => 'Tasks', :ids => "#{ids.to_sentence}")
    end
    redirect url(:tasks, :index)
  end
end
