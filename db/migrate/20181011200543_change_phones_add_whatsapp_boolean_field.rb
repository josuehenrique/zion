class ChangePhonesAddWhatsappBooleanField < ActiveRecord::Migration
  def change
    add_column :phones, :whatsapp, :boolean, null: false, default: true
  end
end
