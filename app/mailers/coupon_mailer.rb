class CouponMailer < ApplicationMailer
  def coupon_associated(user)
    @user = user
    @coupons = user.coupons
    mail(to: @user.email, subject: I18n.t(:you_received_coupons))
  end
end
