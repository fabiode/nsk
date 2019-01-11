RSpec.describe Coupon, type: :model do
  subject { FactoryBot.create :coupon }

  context 'attributes validations' do
    [:number, :series].each do |attr|
      it { should validate_presence_of(attr) }
    end

    it do
      should validate_uniqueness_of(:number).scoped_to(:series)
    end
  end

  context 'on create' do
    it 'should generate automatic uuid' do
      subject.save
      expect(subject.persisted?).to be_truthy
      expect(subject.uuid).not_to be_empty
    end
  end

  context 'on user and order association' do
    let(:user) {FactoryBot.create :user}
    let(:user2) {FactoryBot.create :user}
    let(:order) {FactoryBot.create :order}
    let(:order2) {FactoryBot.create :order}

    context 'if not associated yet' do
      it 'can be associated to an user and an order' do
          CouponAssociationService.associate(order: order, user: user, coupons: [subject])
          expect(subject.user_id).to eql(user.id)
          expect(subject.order_id).to eql(order.id)
      end
    end

    context 'if already associated' do
      before(:each) do
        CouponAssociationService.associate(order: order, user: user, coupons: [subject])
      end

      it 'cannot be withdrawed from user using update' do
        expect { subject.update(user_id: nil, order_id: nil) }.to raise_exception(CouponRemovalNotAllowed)
      end

      it 'cannot be associated to another user using Arel push methods' do
        expect do
          user2.coupons << subject
          order2.coupons << subject
        end.to raise_exception(CouponRemovalNotAllowed)
      end
    end
  end


end
