class CompaniesUsers < ActiveRecord::Migration
  def change
    create_table(:companies_users) do |t|
      t.references :user
      t.references :company

      t.timestamps
    end
  end
end
