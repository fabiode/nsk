class Coupon < ApplicationRecord
  belongs_to :user
  belongs_to :order
  validates :user_id, :order_id, :number, :series, :uuid, presence: true
  validates :number, uniqueness: { scope: :series }

  before_validation :generate_uuid, on: :create
  scope :unused, -> { where(user_id: nil, order_id: nil) }
  scope :random_pick, -> (amount) { order("RAND()").first(amount) }

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
