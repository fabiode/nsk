if Coupon.any?
  puts "DB Seed deactivated: Check if are any coupons on database."
else
  require Rails.root.join('lib/coupon_generator.rb')
  if Rails.env.staging?
    CouponGenerator.generate({ 0 => (0..100), 1 => (0..100)  })
  else
    CouponGenerator.generate
  end
end
