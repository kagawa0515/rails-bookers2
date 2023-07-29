class BooksController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = Book.new
  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id  #投稿時ログインしているユーザーのidを保存する記述
    if @book.save  # データをデータベースに保存するためのsaveメソッド実行
      flash[:notice] = "You have created book successfully."  # 投稿に成功した時のフラッシュメッセージ
      redirect_to book_path(@book)  # 詳細画面へリダイレクト
    else
      @books = Book.all  #renderでindexページを呼び出すなら、indexで定義されている変数も一緒に持ってくること
      @user = User.find(current_user.id)  #ログインしているユーザー情報取得
      render "index"
    end
  end


  def index  #データ一覧表示
    @books = Book.all  #投稿されたずべての本のデータを取得
    @user = User.find(current_user.id)  #ログインしているユーザー
    @users = User.all
    @book = Book.new  #新規投稿の部分テンプレート
  end


  def show  # データ内容詳細表示
    # @user = User.find(current_user.id)
    @book = Book.find(params[:id])
    @books = Book.new
    @user = @book.user
  end


  def edit  # データを更新するためのフォーム
    @book = Book.find(params[:id])  # 投稿した本のデータを取得
    if @book.user == current_user  # URLを入力しても画面に飛ばせない
    render "edit"
    else
    redirect_to books_path
    end
  end


  def update  # データ更新
    @book = Book.find(params[:id]) # 投稿した本のデータを取得
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."  # 更新に成功した時のフラッシュメッセージ
      redirect_to book_path(@book)
    else
      render "edit"
    end
  end


  def destroy  # データ削除
    book = Book.find(params[:id])  # データを1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to books_path  # 一覧ページへリダイレクト
  end


  private


  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end