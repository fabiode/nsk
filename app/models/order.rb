class Order < ApplicationRecord
  validates :user_id, number: presence: true
  validates :number, uniqueness: true
end

