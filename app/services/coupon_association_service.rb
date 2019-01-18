class CouponAssociationService
  def self.associate(order: order, user: user, coupons: coupons)
    ActiveRecord::Base.transaction do
      order.save!
      order.coupons << coupons
      user.coupons << coupons
      coupons.each do |coupon|
        coupon.reload
        Log.create(response: "success", message: "Coupon associated: #{coupon.inspect}", purpose: "CouponAssociationService")
      end
    end
    return true
  end
end
