class Order < ApplicationRecord
  belongs_to :user
  has_many :coupons

  validates :user_id, :number, presence: true
  validates :number, uniqueness: true
end

