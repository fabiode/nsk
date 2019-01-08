RSpec.describe Coupon, type: :model do
  subject { FactoryBot.build :coupon }

  context 'attributes validations' do
    [:user_id, :order_id, :number, :series].each do |attr|
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

end
