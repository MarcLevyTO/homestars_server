class AddStatusToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :status, :string, null: false, default: 'Active'
  end
end
