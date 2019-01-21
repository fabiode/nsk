RSpec.describe User, type: :model do
  subject { FactoryBot.build :user}
  context 'attributes validations' do
    [:name, :surname, :phone, :document, :email, :password].each do |attr|
      it { should validate_presence_of(attr) }
    end

    [:document, :email].each do |attr|
      it do
        should validate_uniqueness_of(attr).case_insensitive
      end
    end

  end
end
