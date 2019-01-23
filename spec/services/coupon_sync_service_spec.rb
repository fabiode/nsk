require Rails.root.join('spec/support/vtex_responses.rb')
require Rails.root.join('lib/coupon_generator.rb')

describe CouponSyncService do
  let(:user) { FactoryBot.create :user}
  subject { CouponSyncService.new(user) }
  before(:all) do
    CouponSyncService::COUPON_VALUE = 150.0
    VtexService::PROMO_NAME = ''
    VtexService::ELIGIBLE_CATEGORY = '106'
  end

  context 'with no coupons' do
    it 'should raise NoCouponsException' do
      expect{ subject }.to raise_exception(NoCouponsException)
    end
  end

  context 'with coupons created' do
    before(:each) { Coupon.stub_chain(:unused, :count).and_return(100) }

    it 'should not raise NoCouponsException' do
      expect{ subject }.not_to raise_exception(NoCouponsException)
    end

    describe '#compare_orders' do
      context 'with no previous orders' do
        before(:each) do
          VtexService.any_instance.stub(:orders).and_return(VtexResponses.elegible_orders_list)
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
          VtexService.any_instance.stub(:orders).and_return(vtex_orders)
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
          expect(subject.send(:coupon_quantity_for, {})).to eq(1)
        end
      end

      context 'with 337.0 in valid purchases' do
        before(:each) do
          VtexService.any_instance
            .stub(:get_order_data)
            .and_return(VtexResponses.elegible_order_data(quantity: 2, item_price: 16850))
        end

        it "should return 2 as coupon quantity" do
          expect(subject.send(:coupon_quantity_for, {})).to eq(2)
        end
      end

      context 'with 620.0 in valid purchases' do
        before(:each) do
          VtexService.any_instance
            .stub(:get_order_data)
            .and_return(VtexResponses.elegible_order_data(quantity: 10, item_price: 6200))
        end

        it "should return 4 as coupon quantity" do
          expect(subject.send(:coupon_quantity_for, {})).to eq(4)
        end
      end

      context 'with 129.0 in valid purchases' do
        before(:each) do
          VtexService.any_instance
            .stub(:get_order_data)
            .and_return(VtexResponses.elegible_order_data(quantity: 10, item_price: 1290))
        end

        it "should return 0 as coupon quantity" do
          expect(subject.send(:coupon_quantity_for, {})).to eq(0)
        end
      end
    end
  end
end
