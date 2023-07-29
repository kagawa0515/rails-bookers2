class Book < ApplicationRecord
	has_one_attached :image
	belongs_to :user

	validates :title, presence: true, length: {minimum: 0} # バリデーション設定
	validates :body, presence: true, length: {minimum: 0, maximum: 200}
end
