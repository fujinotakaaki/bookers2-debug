class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable#, :authentication_keys => [ :name ]

  has_many :books, dependent: :destroy
  attachment :profile_image

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
end
