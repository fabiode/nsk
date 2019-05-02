class CouponReport
  def self.export_used
    coupons = Coupon.where.not(user_id: nil)
    file_path = Rails.root.join('public/export.csv')
    f = File.new(file_path, 'w+')
    CSV.open(file_path, 'wb') do |csv|

      csv << ['Serie', 'Cupom', 'Nome', 'Sobrenome', 'CPF', 'Tel', 'Celular', 'Email', 'Pedido VTEX', 'Cupom Atribuido em', 'UUID']
      coupons.each do |coupon|
        csv << [coupon.series,
                coupon.number,
                coupon.user.name,
                coupon.user.surname,
                coupon.user.document,
                coupon.user.phone,
                coupon.user.mobile_phone,
                coupon.user.email,
                coupon.order.number,
                coupon.updated_at,
                coupon.uuid
               ]
      end
    end
  end
end
