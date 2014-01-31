class CreateCompaniesTable < ActiveRecord::Migration
  def change
    create_table :companies_tables do |t|
      t.name
      
      t.timestamps
    end
  end
end
