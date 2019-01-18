require Rails.root.join('spec/support/vtex_responses.rb')

describe CouponSyncService do
  let(:user) { FactoryBot.create :user}
  subject { CouponSyncService.new(user) }

  describe '#compare_orders' do
    context 'with no previous orders' do
      before(:each) do
        VtexService.any_instance.stub(:get_orders).and_return(VtexResponses.elegible_orders_list)
      end

      it '#new_orders should return same order list' do
        subject.compare_orders
        expect(subject.new_orders).to match_array(VtexResponses.elegible_orders_list)
      end
    end

    context 'with previous orders' do
      let(:quantity) { 5 }
      let(:vtex_orders) { VtexResponses.elegible_orders_list(quantity: quantity) }
      before(:each) do
        VtexService.any_instance.stub(:get_orders).and_return(vtex_orders)
        FactoryBot.create :order, number: vtex_orders.first[:orderId], user: user
      end

      it '#new_orders should return only orders not yet created' do
        subject.compare_orders
        expect(subject.new_orders.size).to be_eql(quantity - user.orders.count)
      end
    end
  end

  describe '#coupon_quantity_for' do
    context 'with 150.0 in valid purchases' do
      before(:each) do
        VtexService.any_instance.stub(:get_order_data).and_return(VtexResponses.elegible_order_data)
      end

      it "should return 1 as coupon quantity" do
        expect(subject.send(:coupon_quantity_for, {})).to be_eql(1)
      end
    end

    context 'with 337.0 in valid purchases' do
      before(:each) do
        VtexService.any_instance
          .stub(:get_order_data)
          .and_return(VtexResponses.elegible_order_data(quantity: 2, item_price: 16850))
      end

      it "should return 2 as coupon quantity" do
        expect(subject.send(:coupon_quantity_for, {})).to be_eql(2)
      end
    end

    context 'with 620.0 in valid purchases' do
      before(:each) do
        VtexService.any_instance
          .stub(:get_order_data)
          .and_return(VtexResponses.elegible_order_data(quantity: 10, item_price: 6200))
      end

      it "should return 4 as coupon quantity" do
        expect(subject.send(:coupon_quantity_for, {})).to be_eql(4)
      end
    end

    context 'with 129.0 in valid purchases' do
      before(:each) do
        VtexService.any_instance
          .stub(:get_order_data)
          .and_return(VtexResponses.elegible_order_data(quantity: 10, item_price: 1290))
      end

      it "should return 0 as coupon quantity" do
        expect(subject.send(:coupon_quantity_for, {})).to be_eql(0)
      end
    end
  end
end