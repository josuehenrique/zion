class ChangePhonesAddWhatsappBooleanField < ActiveRecord::Migration[4.2]
  def change
    add_column :phones, :whatsapp, :boolean, null: false, default: true
  end
end
