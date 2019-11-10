class Profile < ApplicationRecord
  belongs_to :user
  # POST_NUMBER_VALID = /\A\d{3}-\d{4}\z/i
  # バリデーション
  validates :nickname,              presence: true, length: {maximum: 20}
  validates :birthday,                presence: true
  validates :last_name,             presence: true, length: {maximum: 35}
  validates :first_name,           presence: true, length: {maximum: 35}
  validates :last_name_kana,        presence: true, length: {maximum: 35}
  validates :first_name_kana,      presence: true, length: {maximum: 35}
  # validates :post_number,             presence: true, length: {maximum: 100}, format: { with: POST_NUMBER_VALID }
  validates :prefecture,              presence: true, length: {maximum: 100}
  validates :city,                    presence: true, length: {maximum: 50}
  validates :house_number,                 presence: true, length: {maximum: 100}
  validates :building_name,                                 length: {maximum: 100}
  validates :tel_number,                                     length: {maximum: 100}
end