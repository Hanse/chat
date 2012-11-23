String::htmlEncode = () ->
  this.replace /[&<>"']/g, ($0) ->
    "&" + {"&":"amp", "<":"lt", ">":"gt", '"':"quot", "'":"#39"}[$0] + ";"

String::linkify = () ->
  this.replace /(https?:\/\/[-.\/\w]+)/, (match) ->
    "<a href='#{match}' target='_blank'>#{match}</a>"

String::clean = () ->
  this.replace /\W/g, (chr) ->
    "&##{chr.charCodeAt(0)};"

exports.scrollToBottom = (el) ->
  $(el).each ->
    scrollHeight = Math.max(this.scrollHeight, this.clientHeight)
    this.scrollTop = scrollHeight - this.clientHeight

exports.displayTime = (date) ->
  hours = date.getHours()
  minutes = date.getMinutes()
  hours  = "0#{hours}" if hours < 10
  minutes = "0#{minutes}" if minutes < 10

  "#{hours}:#{minutes}"