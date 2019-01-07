class User < ApplicationRecord
  validates :document, :email, uniqueness: { case_sensitive: false }
  validates :name, :surname, :phone, :document, :email, presence: true

  has_many :coupons
  has_many :orders
end
