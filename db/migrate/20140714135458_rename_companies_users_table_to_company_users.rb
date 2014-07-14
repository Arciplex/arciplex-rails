class RenameCompaniesUsersTableToCompanyUsers < ActiveRecord::Migration
  def change
    rename_table :companies_users, :company_users
  end
end
