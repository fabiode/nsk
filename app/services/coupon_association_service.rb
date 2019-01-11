class CouponAssociationService
  def self.associate(order: order, user: user, coupons: coupons)
    ActiveRecord::Base.transaction do
      order.coupons << coupons
      user.coupons << coupons
      user.orders << order
      coupons.each do |coupon|
        coupon.reload
        Log.create(response: "success", message: "Coupon associated: #{coupon.inspect}", purpose: "CouponAssociationService")
      end
    end
  end
end
