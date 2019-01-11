class CouponsController < ApplicationController
  before_action :authenticate_user!

  def index
    @coupons = Coupon.where(user: current_user)
  end
end
