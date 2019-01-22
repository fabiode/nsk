class CouponsController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!

  def index
    @coupons = Coupon.where(user: current_user)
  end

  def sync
    begin
      syncr = CouponSyncService.new(current_user)
      syncr.compare_orders

      if syncr.sync
        flash[:success] = I18n.t(:sync_successful)
      else
        flash[:alert] = I18n.t(:empty_order_list)
      end

      @coupons = current_user.coupons.reload
      respond_with @coupons, location: coupons_url
    rescue NoCouponsException => e
      redirect_to coupons_path, alert: I18n.t(:no_more_coupons)
    end
  end
end
