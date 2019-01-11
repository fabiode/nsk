class CouponGenerator

  def self.generate(range_hash: { 0 => (0..99999), 1 => (0..99999) })
    range_hash.each do |series, coupon_range|
      coupon_range.each do |number|
        p "Creating Coupon #{series}/#{number}..."
        current_coupon = Coupon.new(number: number, series: series)

        if current_coupon.save
          message = "Coupon #{current_coupon.series}/#{current_coupon.number} created successfully with uuid #{current_coupon.uuid}"
          response = "success"
        else
          message = "ERROR: Coupon #{series}/#{number} not created! #{current_coupon.errors.map}"
          response = "error"
        end

        Log.create(response: response, message: message, purpose: "CouponGenerator")
        p "== # #{response} =="
        p message
        p "================"
      end
    end
  end

  def self.log_to_text

  end
end
