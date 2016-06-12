require "rails_helper"

RSpec.feature "User can create an account" do
  context "with valid info" do
    it "redirects them to the home page and displays a flash message" do
        visit new_user_registration_path

        fill_in "form-create-account-email",            with: "user@example.com"
        fill_in "form-create-account-password",         with: "password"
        fill_in "form-create-account-confirm-password", with: "password"
        click_button "Create Account"

        # should probably take them homes index upon login when thats implemented
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Welcome! You have signed up successfully.")
        expect(page).to have_content("Sign out")
    end
  end

  context "with invalid info" do
    it "redirects them back to user new page with errors displayed" do
      visit new_user_registration_path

      fill_in "form-create-account-email",            with: "user@example.com"
      fill_in "form-create-account-password",         with: "password"
      fill_in "form-create-account-confirm-password", with: "notapassword"
      click_button "Create Account"

      expect(current_path).to eq("/users")
      expect(page).to have_content("Password confirmation doesn't match Password")
      expect(page).to have_content("Sign in")
    end
  end
end
