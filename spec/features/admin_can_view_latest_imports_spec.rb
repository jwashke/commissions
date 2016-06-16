require "rails_helper"

RSpec.feature "User can view listings index" do
  context "as a logged in admin" do
    it "displays the import info" do
      admin = create(:signed_user, admin: true)
      login_as admin
      import = create(:import)

      visit admin_latest_import_path

      expect(page).to have_content("Last import started at: #{import.time_started}")
      expect(page).to have_content("Completed in: #{import.total_time} seconds")
      expect(page).to have_content("Previous number of active records: #{import.prev_quantity_active}")
      expect(page).to have_content("Current number of active records: #{import.current_quantity_active}")
    end
  end

  context "as a logged in non admin user" do
    it "gives them a 404 page" do
      user = create(:user)
      login_as user
      import = create(:import)

      visit admin_latest_import_path

      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end

  context "as a guest user" do
    it "redirects them to the welcome page to sign in or create an account" do
      import = create(:import)

      visit admin_latest_import_path

      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
