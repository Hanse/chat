utils = require("../utils")
scrollToBottom = utils.scrollToBottom
displayTime = utils.displayTime

module.exports = class ChatView
  constructor: (options) ->
    @el = options.el

  appendMessage: (username, message, date) ->
    $("<p></p>").html("<strong>#{username}</strong>: #{message.htmlEncode().linkify()} <time>#{displayTime(date)}</time>").appendTo(@el)
    scrollToBottom(@el)

  appendNotification: (message, date) ->
    $("<p class='notification'></p>").html("<strong>Chuck Norris</strong>: #{message.htmlEncode().linkify()} <time>#{displayTime(date)}</time>").appendTo(@el)
    scrollToBottom(@el)