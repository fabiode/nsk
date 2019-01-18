module CouponsHelper
  def format_coupon(coupon)
    [format_coupon_series(coupon), format_coupon_number(coupon)].join('/')
  end

  def format_coupon_series(coupon)
    coupon.series.to_s.rjust(2, '0')
  end

  def format_coupon_number(coupon)
    coupon.number.to_s.rjust(5, '0')
  end
end
