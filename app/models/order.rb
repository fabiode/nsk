class Order < ApplicationRecord
  belongs_to :user
  has_many :coupons, -> { readonly(true) }

  validates :user_id, :number, presence: true
  validates :number, uniqueness: true
end

