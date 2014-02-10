class UsersController < ApplicationController
  before_filter :require_current_user!, :only => [:index, :show]
  before_filter :require_no_current_user!, :only => [:create, :new]

  def create
    @user = User.new(params[:user])

    if @user.save
      self.current_user = @user
      redirect_to user_url(@user)
    else
      render :json => @user.errors.full_messages
    end
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    if !params.include?(:id)
      redirect_to user_url(current_user)
      return
    end

    @user = User.find(params[:id])
  end
end
