class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクト
    else
      flash.now[:danger] = 'Invalid email/password combination' # 正しくない
      render 'new'
    end
  end

  def destroy
  end
end
