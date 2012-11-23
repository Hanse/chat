express  = require("express")
app      = express()
io       = require("socket.io").listen(app.listen(process.env.PORT))

console.log process.env.PORT

app.configure ->
  app.use(express.static(__dirname + '/public'))
  app.use(express.errorHandler(dumpExceptions: true, showStack: true ))

app.get "/", (request, response) ->
  response.render "index"

clients = {}
numberOfGuests = 0

io.sockets.on "connection", (socket) ->
  socket.on "send", (message) ->
    console.log "#{clients[socket.id]} said '#{message}' at #{new Date()}"
    socket.broadcast.emit "should play sound"
    io.sockets.emit "message received", {username: clients[socket.id], message: message}

  socket.on "join", (data) ->
    console.log "data", socket.handshake
    if data.username is "Guest"
      numberOfGuests += 1
      data.username = "Guest #{numberOfGuests}"
      console.log "Guests", numberOfGuests

    if data.username in (name for socketId, name of clients)
      socket.emit "username taken"
      return false

    clients[socket.id] = data.username
    socket.username = data.username
    console.log "#{data.username} connected from #{socket.handshake.address.address}"

    socket.emit "notification received", message: "Du er nå online"
    socket.broadcast.emit "notification received", message: "#{data.username} er nå online."
    socket.broadcast.emit "should play sound"
    io.sockets.emit "users changed", users: clients
  
  socket.on "disconnect", ->
    username = clients[socket.id]
    delete clients[socket.id]
    if username.indexOf "Guest" isnt 1
      numberOfGuests -= 1
    console.log "#{username} disconnected."
    io.sockets.emit "users changed", users: clients
    socket.broadcast.emit "notification received", message: "#{username} koblet fra."



