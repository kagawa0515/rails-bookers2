class UsersController < ApplicationController
  # before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update] #[]にはURLを打っても行かせない
  def index  #データ一覧表示
    @users = User.all
    @book = Book.new
    @user = User.find(current_user.id)  #ログインしているユーザー
    @books = @user.books
  end

  def edit  # データを更新するためのフォーム
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def show  # データ内容詳細表示
    @user = User.find(params[:id])
    @book = Book.new # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成
    @books = @user.books #@userにはユーザー情報、そこに紐づいているbooksモデルの本たち
  end

  def update  # データ更新
    @user = User.find(params[:id])  # ユーザーの取得
    @user.id = current_user.id
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."  # 更新に成功した時のフラッシュメッセージ
      redirect_to user_path(@user.id)  # ユーザーの詳細ページへのパス
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end

  def ensure_correct_user #[]にはURLを打ったらユーザー詳細に返す
    @user = User.find(params[:id])
    unless @user == current_user
        redirect_to user_path(current_user)
    end
  end
end
