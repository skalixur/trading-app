class ChangeColumnDefaultForIsApproved < ActiveRecord::Migration[8.0]
  def change
    change_column_default(:users, :is_approved, from: nil, to: false)
  end
end
