if Coupon.any?
  puts "DB Seed deactivated: Check if are any coupons on database."
else
  require Rails.root.join('lib/coupon_generator.rb')
  CouponGenerator.generate
end
