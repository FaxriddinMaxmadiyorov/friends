class ActivityChannel < ApplicationCable::Channel
  def subscribed
    stream_from "activity_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def appear 
    ActionCable.server.broadcast "activity_channel", user_id: current_user.id
  end

  private

  def current_user
    connection.current_user
  end
end
