class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Usuario sem possue permissao.'
      @users = User.all
  end

  def show
    authorize! :show, @user, :message => 'Usuario sem possue permissao.'
    @user = User.find(params[:id])
  end
  
  def update
    authorize! :update, @user, :message => 'Usuario sem possue permissao.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Usuario sem possue permissao.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def add_new_password_encrypted
    old_users = []
    new_users = User.all
    new_users.each do |user|
      if user.encrypted_password.blank?
        user.encrypted_password = User.new(:password => user["pwd"]).encrypted_password
      else
        old_users << user.name
      end
      if user.profile_picture.blank?
        user.profile_picture = 'male_profile.png'
      end
      user.save!
    end
    old_users
  end
end