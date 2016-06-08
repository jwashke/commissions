require "rails_helper"

RSpec.feature "User can login to an existing account" do
  context "with valid info" do
    it "redirects them to the home page and displays a flash message" do
        user = create(:user, email: "user@example.com", password: "password")

        visit new_user_session_path

        fill_in "form-create-account-email",            with: "user@example.com"
        fill_in "form-create-account-password",         with: "password"
        click_button "Sign In"

        # should probably take them homes index upon login when thats implemented
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Signed in successfully.")
        expect(page).to have_content("Sign Out")
    end
  end

  context "with invalid info" do
    it "redirects them back to login page with errors displayed" do
      user = create(:user, email: "user@example.com", password: "password")

      visit new_user_session_path

      fill_in "form-create-account-email",            with: "user@example.com"
      fill_in "form-create-account-password",         with: "notapassword"
      click_button "Sign In"

      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_content("Invalid Email or password.")
      expect(page).to have_content("Sign in")
    end
  end
end
