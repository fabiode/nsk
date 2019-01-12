class CouponSyncService
  attr_reader :user, :current_orders, :new_orders, :vtex_client

  def initialize(user)
    @user = user
    @current_orders = user.orders
    @vtex_client = VtexService.new(@user)
  end

  def compare_orders
    orders = VtexService.get_orders
    orders.reject! { |new_order| current_orders.exist?(number: new_order[:orderId]) }
    @new_orders = orders
  end

  def sync
    new_orders.each do |order|
      coupon_quantity = coupon_quantity_for(order)
      next if coupon_quantity == 0

      pick_coupons(order, coupon_quantity)
    end
  end

  private

  def pick_coupons(order, amount)
    ActiveRecord::Base.transaction do
      coupons = Coupon.unused.random_pick(amount)
      CouponAssociationService.associate(order: order, user: user, coupons: coupons)
    end
  end

  def coupon_quantity_for(order)
    order_data = VtexService.get_order_data(order)

    return 0 if order_data.elegible_products_amount.floor == 0
    (order_data[:elegible_products_amount] / VtexService.COUPON_VALUE).floor
  end
end
