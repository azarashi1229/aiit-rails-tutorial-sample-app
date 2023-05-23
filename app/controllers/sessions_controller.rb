class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # if user && user.authenticate(params[:session][:password])
    # ぼっち演算子
    if user&.authenticate(params[:session][:password])
      reset_session      # ログインの直前に必ずこれを書くこと
      remember user
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'

      # エラーメッセージを作成する
      render 'new', status: :unprocessable_entity
    end
  end

  # このdestroyアクションでは、リダイレクト時にstatus: :see_otherというHTTPステータスも指定している点にご注意ください。
  # RailsでTurboを使うときは、このように303 See Otherステータスを指定することで、DELETEリクエスト後のリダイレクトが正しく振る舞うようにする必要があります24 。\
  # リスト 7.18で使われているステータスコード:unprocessable_entityと見比べてみてください。
  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
