class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # debugger
  end
  def new
    @user = User.new
  end
  def create
    # @user = User.new(params[:user])    # 実装は終わっていないことに注意!
    # Strong Parameter対応
    @user = User.new(user_params)

    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
