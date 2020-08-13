class AddStatusToChannel < ActiveRecord::Migration[6.0]
  def change
    add_column :channels, :status, :string, null: false, default: 'Active'
  end
end
