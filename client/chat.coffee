
utils       = require("./utils")
ChatView    = require("./views/chat_view")
ClientsView = require("./views/clients_view")

sound = new Audio()
sound.src = "assets/sounds/beep.mp3"
sound.load()

chatView    = new ChatView(el: $("#room"))
clientsView = new ClientsView(el: $("#users ul"))

socket = io.connect()

socket.on "connect", ->
  socket.emit "join", username: prompt("Name:") or "Guest"
  $("#data").focus()

socket.on "username taken", ->
  alert "username already taken"
  socket.emit "join", username: prompt("Name:")
  $("#data").focus()

socket.on "message received", (data) ->
  chatView.appendMessage(data.username, data.message, new Date())

socket.on "notification received", (data) ->
  chatView.appendNotification(data.message, new Date())

socket.on "should play sound", ->
  sound.play() if $("#enable_beeping").is(":checked")

socket.on "users changed", (data) ->
  clientsView.render(data.users)

$("#data").keypress (event) ->
  if event.keyCode is 13
    $data = $("#data")
    socket.emit("send", $data.val()) if $data.val() isnt ""
    $("#data").val("")