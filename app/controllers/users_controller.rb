class UsersController < ApplicationController
  #TODO: <CLINT> : properly add user control  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated
    if @user.save
      flash[:notice] = "Your account has been created."
      redirect_to signup_url
    else
      flash[:notice] = "There was a problem creating you."
      render :action => :new
    end

  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  

  #the user page!
  #GET -- accepts user_id only !! 
  #todo: add to routes, implement function
  #create a view file under 
  #/users/view.html.erb
  #update routes
  def view
    require_user
    #@question = User.find(Integer(params["id"]))
    if (!params[:id].nil?)
      id = Integer(params[:id])
      @user = User.find(id) # return the user object
    else
      #trying to view a user page without a user-id
      #to be done -- this is an error state, just display an error message
     # redirect_to controller:"qa", action:"view_question", id:@question.id
      #render 'forum/index'
    end
  end
  
  #TODO: <DOUG> : handle an upload resource post request
  def upload_user_file
    #on complete, redirect back to current user's page
  end
  
  #TODO: <DOUG> : delete selected resource
  def delete_user_file
    id = Integer(params["id"])
    require_boolean current_user.id == UserFile.find(id).user_id
  
  end
  
  #handled by route
  def registrar_form
    require_manager
  end
  
  #TODO : <DOUG> : implement hte upload feature. post data contains the ENTIRE FILE! https://www.tutorialspoint.com/ruby-on-rails/rails-file-uploading.htm
  #http://stackoverflow.com/questions/14174044/uploading-a-file-in-rails
  def handle_upload
    require_manager
    #redirect  back to hte registrar form.
    #redirect_to registrar_form

  end
  
  #list all of the users in the system for hte admin...
  def list
    require_admin
    @Users = Users.all
  end
  
  
  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :role_id)
  end
  
  #TODO: <DOUG> : pull file data from params
  def upload_user_file_params
  end
  
  #TODO: <DOUG> : pull file data from params
  def upload_registrar_params
  end
  
end
