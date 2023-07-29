Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users, only: [:index, :show, :edit, :update] do
  end

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    delete 'books/:id' => 'books#destroy', as: 'destroy_book'
  end
end
# new(新規作成),create(データ追加保存),index(データ一覧表示),show(データ内容詳細表示)
# edit(データを更新するためのフォーム),update(データ更新),destroy(削除)
#GET	データの取得(ページ自体もデータ)
#POST	新しいデータの作成
#PUT	既存のデータの更新
#PATCH	既存のデータの一部更新
#DELETE	既存のデータを削除