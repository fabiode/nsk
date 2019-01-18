class CouponsController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!

  def index
    @coupons = Coupon.where(user: current_user)
  end

  def sync
    syncr = CouponSyncService.new(current_user)
    syncr.compare_orders
    syncr.sync

    @coupons = current_user.coupons.reload
    respond_with @coupons do |f|
      f.html { redirect_to coupons_path, success: t(:sync_successful) }
      f.js { flash[:success] = t(:sync_successful) }
    end
  end
end
