class ChangeDataProfileTelNumber < ActiveRecord::Migration[5.0]
  def change
    change_column :profiles, :tel_number, :string
  end
end
