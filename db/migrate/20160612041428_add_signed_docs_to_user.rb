class AddSignedDocsToUser < ActiveRecord::Migration
  def change
    add_column :users, :signed_docs, :boolean, default: false
  end
end
