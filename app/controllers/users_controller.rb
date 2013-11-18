class UsersController < ApplicationController
  respond_to :html, :xml, :xls, :json, :js
  # overrides built in devise users_controller

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  # enables admin to change another user's subscription plans and
  # update Stripe customer account, which will apply refunds, charges needed
  def update                    # for changing user's role
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])        # , :as => :admin)
      @user.update_role(role) unless role.nil?
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alsert => "Unable to update user."
    end
  end

  def destroy                   # only admins can destroy users
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user   # ensure admin can't delete himself
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end