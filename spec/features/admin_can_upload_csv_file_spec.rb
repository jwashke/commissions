require "rails_helper"

RSpec.feature "User can view listings index" do
  context "as a logged in admin" do
    it "displays the import info" do
      admin = create(:signed_user, admin: true)
      login_as admin

      visit new_admin_import_path
      attach_file "file", "spec/data/test.csv", visible: false
      click_button("Import CSV")

      expect(current_path).to eq(admin_latest_import_path)
      expect(page).to have_content("Previous number of active records: 0")
      expect(page).to have_content("Current number of active records: 4")
    end
  end

  context "as a logged in non admin user" do
    it "gives them a 404 page" do
      user = create(:user)
      login_as user
      import = create(:import)

      visit new_admin_import_path

      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end

  context "as a guest user" do
    it "redirects them to the welcome page to sign in or create an account" do
      import = create(:import)

      visit new_admin_import_path

      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
