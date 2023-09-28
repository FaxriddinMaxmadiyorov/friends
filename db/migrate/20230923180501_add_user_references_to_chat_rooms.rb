class AddUserReferencesToChatRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :chat_rooms, :first_user_id, :integer
    add_column :chat_rooms, :second_user_id, :integer

    add_foreign_key :chat_rooms, :users, column: :first_user_id
    add_foreign_key :chat_rooms, :users, column: :second_user_id
  end
end
