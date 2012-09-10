express = require("express")
app     = express()
port = process.env.PORT || 8124
io      = require("socket.io").listen(app.listen(port))

app.configure ->
  app.use(express.static(__dirname + '/public'))
  app.use(express.errorHandler(dumpExceptions: true, showStack: true ))


app.get "/", (request, response) ->
  response.render "index"

class User
  @name = "Anonymous"
  constructor: (@name) ->
  say: (message) ->
    message


users = {}
bot = new User("Leksepolitiet")

io.sockets.on "connection", (socket) ->
  socket.on "send", (data) ->
    io.sockets.emit "update_chat", socket.user, data

  socket.on "join", (username) ->
    user = new User(username)
    socket.user = user
    users[user.name] = user 
    socket.emit "update_chat", bot, "You have connected."
    socket.broadcast.emit "update_chat", bot, "#{user.name} has connected."
    io.sockets.emit "update_users", users

  socket.on "disconnect", ->
    delete users[socket.user.name]
    io.sockets.emit("update_users", users)
    socket.broadcast.emit("update_chat", bot, "#{socket.user.name} has disconnected.")