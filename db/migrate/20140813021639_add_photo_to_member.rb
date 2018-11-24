class AddPhotoToMember < ActiveRecord::Migration[4.2]
  def change
    add_attachment :members, :photo
  end
end
