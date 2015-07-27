class AddUserIdToExpenditure < ActiveRecord::Migration
  def change
    add_column :expenditures, :user_id, :integer
  end
end
