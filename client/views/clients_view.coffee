module.exports = class ClientsView
  constructor: (options) ->
    @el = options.el

  render: (users) ->
    @el.empty()
    @el.append "<li>#{username}</li>" for socketId, username of users