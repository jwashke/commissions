require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password)}
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe "#confirmation_required?" do
    it "returns false" do
      user = create(:user)

      expect(user.confirmation_required?).to be(false)
    end
  end
end

class User < ActiveRecord::Base
  public :confirmation_required?
end
