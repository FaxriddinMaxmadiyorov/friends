import consumer from "./consumer"

consumer.subscriptions.create("ActivityChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    this.perform('appear');
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    let elements = document.getElementsByClassName(`user-${data.user_id}`);
    for (var i = 0; i < elements.length; i++) {
      elements[i].classList.add('online');
    }
  }
});
