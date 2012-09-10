A chat written in CoffeeScript using Node.js and socket.io. It includes a server and a client.

Run it with `foreman start`. You'll need the `foreman` gem to do that.

Now go to `http://localhost:8124/` to see the chat in its full glory.

client: coffee --watch --compile --output ./public ./public
server: coffee --watch --bare chat.coffee
compass: compass watch .