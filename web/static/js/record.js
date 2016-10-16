import socket from "./socket"

$(function() {
//   let ul = $("ul#show-list")
//   if (ul.length) {
    // var id = ul.data("id")
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
//   }

    var addRecord = function (name) {
      channel.push("add", { name: name }).receive("ok", payload => {
        console.log(payload);
      });
    }

  $('body').on('click', '.dividing.header', function () {
      $('.form').toggle('hidden');
  });

  $('.form').on('click', 'button', function(e){
    e.preventDefault();
    addRecord("judo");

    console.log($('form').serialize());
  });

  channel.on("add", function (p) {
    console.log(p);
  });
});