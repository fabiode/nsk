class Coupon < ApplicationRecord
  validates :user_id, :order_id, :number, :series, :uuid, presence: true
  validates :number, uniqueness: { scope: :series }

  before_create :generate_uuid

  private

  def generate_uuid
    uuid = SecureRandom.uuid
  end
end
