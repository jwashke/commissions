require "rails_helper"

RSpec.feature "User can edit their account" do
  context "with valid info" do
    it "redirects them to the home page and displays a flash message" do
      user = create(:user)
      login_as user, scope: :user
      visit edit_user_registration_path

      fill_in "form-create-account-email",            with: "newemail@example.com"
      fill_in "form-create-account-password",         with: "newPassword"
      fill_in "form-create-account-confirm-password", with: "newPassword"
      fill_in "form-create-account-current-password", with: "password"
      click_button "Update"

        # should probably take them homes index upon login when thats implemented
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Your account has been updated successfully")
      within(".navbar") do
        expect(page).to have_content("newemail@example.com")
      end
    end

    context "with invalid info" do
      it "redirects them to the home page and displays a flash message" do
        user = create(:user)
        login_as user, scope: :user
        visit edit_user_registration_path

        invalid_email = "user"

        fill_in "form-create-account-email",            with: invalid_email
        fill_in "form-create-account-password",         with: "newPassword"
        fill_in "form-create-account-confirm-password", with: "newPassword"
        fill_in "form-create-account-current-password", with: "password"
        click_button "Update"

          # should probably take them homes index upon login when thats implemented

        expect(current_path).to eq("/users")
        expect(page).to have_content("Email is invalid")
        within(".navbar") do
          expect(page).to have_content(user.email)
        end
      end
    end
  end
end
