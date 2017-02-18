import socket from "./socket"

$(function() {
    var topic = "records:76"

    // Join the topic
    let channel = socket.channel(topic, {})
    channel.join()
      .receive("ok", data => {
        console.log("Joined topic", topic)
      })
      .receive("error", resp => {
        console.log("Unable to join topic", topic)
      });

    var addRecord = function (name) {
      channel.push("add", { name: name }).receive("ok", payload => {
        console.log(payload);
      });
    }

  channel.on("add", function (p) {
    console.log(p);
  });
});