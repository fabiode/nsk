class Coupon < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order, optional: true
  validates :number, :series, :uuid, presence: true
  validates :number, uniqueness: { scope: :series }

  before_validation :generate_uuid, on: :create
  before_save :block_removal, on: :update
  scope :unused, -> { where(user_id: nil, order_id: nil) }
  scope :random_pick, -> (amount) { order("RAND()").first(amount) }

  private

  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def block_removal
    if user_id_was.is_a?(Integer) && changes.include?("user_id")
      raise CouponRemovalNotAllowed
    end

    if order_id_was.is_a?(Integer) && changes.include?("order_id")
      raise CouponRemovalNotAllowed
    end
  end
end

class CouponRemovalNotAllowed < Exception
end
