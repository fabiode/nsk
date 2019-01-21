class VtexService
  include HTTParty
  base_uri 'http://klasme.vtexcommercestable.com.br/api/oms/pvt/orders'
  API_KEY = ENV.fetch("VTEX_API_KEY", nil)
  API_TOKEN = ENV.fetch("VTEX_API_TOKEN", nil)
  PROMO_NAME = ENV.fetch("PROMO_NAME", Rails.env.production? ? 'PromoNSK' : 'TESTENSK') # Rates & benefits filter to avoid large amount of orders in list
  ELIGIBLE_CATEGORY = ENV.fetch('ELIGIBLE_CATEGORY', '102') # 102 SkinCare VTEX Category ID
  VALID_STATES = %w(payment-approved ready-for-handling handling invoiced) # Valid order states in VTEX to set order as eligible

  attr_reader :orders, :user, :last_order_data

  def initialize(user)
    @user = user
  end

  def get_orders
    response = self.class.get("?q=#{@user.document}&f_RnB=#{PROMO_NAME}&per_page=100", headers: headers, format: :plain)
    response = JSON.parse response, symbolize_names: true
    if response[:paging][:total] >= 1
      @orders = response[:list]
      reject_by_state
    else
      @orders = []
    end
  end

  def get_order_data(order)
    response = self.class.get("/#{order[:orderId]}", headers: headers, format: :plain)
    response = JSON.parse response, symbolize_names: true
    @last_order_data = response
  end

  def relevant_order_data(order)
    order_data = get_order_data(order)
    relevant_data = {}
    relevant_data[:elegible_products_amount] = elegible_products_amount(order_data)
    relevant_data
  end

  private
  attr_writer :orders

  def headers
    { "Accept": "application/json",
      "Content-Type": "application/json",
      'X-VTEX-API-AppKey': API_KEY,
      'X-VTEX-API-AppToken': API_TOKEN
    }
  end

  def reject_by_state
    @orders.select! do |order|
      VALID_STATES.include? order[:status]
    end
  end


  def elegible_products_amount(order)
    elegible_items = order[:items].select do |item|
      categories = item[:additionalInfo][:categoriesIds].split('/').reject { |n| n.blank? }
      categories.include?(ELIGIBLE_CATEGORY)
    end

    elegible_items.sum { |item| item[:sellingPrice] * item[:quantity] } / 100.0
  end
end
