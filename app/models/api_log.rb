class ApiLog < ApplicationRecord
  before_validation :generate_uuid, on: :create

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
