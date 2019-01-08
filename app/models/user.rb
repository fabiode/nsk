class User < ApplicationRecord
  validates :document, :email, uniqueness: { case_sensitive: false }
  validates :name, :surname, :phone, :document, :email, presence: true
  validates_with CpfValidator

  has_many :coupons
  has_many :orders
end
