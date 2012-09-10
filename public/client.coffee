socket = io.connect()


makeSafe = (str) ->
  str.replace /\W/g, (chr) ->
    "&##{chr.charCodeAt(0)};"

scroll = (elem) ->
  $(elem).each ->
    scrollHeight = Math.max(this.scrollHeight, this.clientHeight)
    this.scrollTop = scrollHeight - this.clientHeight

$("#data").attr "disabled", "disabled"

socket.on "connect", ->
  socket.emit "join", prompt("Name:") or "Anonymous"
  $("#data").removeAttr "disabled"
  $("#data").focus()

socket.on "update_chat", (user, data) ->
  $("<p></p>").html("<strong>#{user.name}:</strong> #{makeSafe(data)}").appendTo("#room")
  scroll("#room")

socket.on "update_users", (users) ->
  $("#users ul").empty()
  $.each users, (key, value) ->
    $("#users ul").append "<li>#{key}</li>"

$("#data").keypress (event) ->
  if event.keyCode is 13
    socket.emit "send", $("#data").val()
    $("#data").val("")
