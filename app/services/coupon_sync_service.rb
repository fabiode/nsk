class CouponSyncService
  COUPON_VALUE = ENV.fetch('COUPON_VALUE', 150.0).to_f
  attr_reader :user, :current_orders, :new_orders, :vtex_client

  def initialize(user)
    @user = user
    @current_orders = user.orders
    @vtex_client = VtexService.new(@user)
  end

  def compare_orders
    orders = vtex_client.get_orders
    orders.reject! { |new_order| Order.exists?(number: new_order[:orderId]) }
    @new_orders = orders
  end

  def sync
    new_orders.each do |vtex_order|
      coupon_quantity = coupon_quantity_for(vtex_order)
      next if coupon_quantity == 0

      order = Order.build(number: vtex_order[:orderId], user: @user)
      pick_coupons(order, coupon_quantity)
    end
    true
  end

  private

  def pick_coupons(order, amount)
    ActiveRecord::Base.transaction do
      coupons = Coupon.unused.random_pick(amount)
      CouponAssociationService.associate(order: order, user: user, coupons: coupons)
    end
  end

  def coupon_quantity_for(vtex_order)
    order_data = vtex_client.relevant_order_data(vtex_order)

    return 0 if order_data[:elegible_products_amount] < COUPON_VALUE
    (order_data[:elegible_products_amount] / COUPON_VALUE).floor
  end
end
