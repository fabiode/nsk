class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable

  validates :document, :email, uniqueness: { case_sensitive: false }
  validates :name, :surname, :phone, :document, :email, presence: true
  validates_with CpfValidator

  has_many :coupons, dependent: :restrict_with_exception
  has_many :orders, dependent: :restrict_with_exception
end
