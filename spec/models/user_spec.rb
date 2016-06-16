require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password)}
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe "#sign_docs" do
    it "changes the users signed docs attribute to true and save it" do
      user = create(:user)

      user.sign_docs
      expect(user.signed_docs).to be(true)
    end
  end

  describe "#admin?" do
    context "user is an admin" do
      it "returns true" do
        user = create(:user, admin: true)

        expect(user.admin?).to be_truthy
      end
    end

    context "user is not an admin" do
      it "returns false" do
        user = create(:user)

        expect(user.admin?).to be_falsy
      end
    end
  end
end

class User < ActiveRecord::Base
  public :confirmation_required?
end
