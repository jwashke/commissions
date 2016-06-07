require "rails_helper"

RSpec.feature "User can create an account" do
  context "with valid info" do
    it "redirects them to a page to sign documents" do
        visit new_user_registration_path

        fill_in "Email",                 with: "user@example.com"
        fill_in "Password",              with: "password"
        fill_in "Password confirmation", with: "password"
        click_button "Sign up"

        # should probably take them homes index upon login when thats implemented
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Welcome")

    end
  end

  context "with invalid info" do
    it "redirects them back to user new page with errors displayed" do

    end
  end
end
