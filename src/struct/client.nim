import event, ws, user, emoji, server, channel, json, asyncdispatch, jsony,
        options, strformat, strutils, httpClient

type RevoltClient* = ref object of RootObj
    ws: WebSocket
    httpClient*: AsyncHttpClient
    token: string
    users*: seq[User]
    servers*: seq[Server]
    emojis*: seq[Emoji]
    channels*: seq[BaseChannel]
    connected*: bool
    events: seq[Event]

proc newRevoltClient*(token: string): RevoltClient =
    let websocket = waitFor newWebSocket(
      "wss://ws.revolt.chat?version=1&format=json")
    let header = newHttpHeaders()
    header.add("x-session-token", token)
    return RevoltClient(ws: websocket,
        httpClient: newAsyncHttpClient(userAgent = "nimrevolt/0.0.0",
                headers = header),
        token: token,
        users: @[], servers: @[], emojis: @[], channels: @[], connected: false,
          events: @[])

proc addRevoltEvent*(self: RevoltClient, eventName: string, run: proc (
        args: JsonNode)) =
    let event = Event(name: eventName, handler: run)
    self.events.add(event)

proc handleEvent(self: RevoltClient) {.async.} =
    let rawJson = await self.ws.receiveStrPacket()
    if rawJson.len >= 1:
        try:
            let json = rawJson.fromJson()

            let eventName = json["type"].getStr()

            # Initialize cache
            if eventName == "Ready":
                let event = rawJson.fromJson(ReadyEvent)
                self.channels = event.channels
                self.users = event.users
                self.servers = event.servers
                if event.emojis.isSome():
                    self.emojis = event.emojis.get()

            # no fucking reason to continue (might bring back in the future... maybe?)
            elif eventName == "Authenticated":
                return

            for _, item in self.events.pairs:
                if $item == eventName.toLower() or $item == "raw":
                    echo fmt"Found event: {$item}"
                    try:
                        item.handler(json)
                    except CatchableError as e:
                        echo fmt"There was error running that event - {e.msg}"

        except JsonParsingError:
            echo "There was problem parsing, here's raw response\n" & rawJson

proc login*(self: RevoltClient): Future[void] {.async.} =
    let auth = %*
        {
            "type": "Authenticate",
            "token": self.token
        }
    await self.ws.send($auth)
    self.connected = true
    self.ws.setupPings(25.0)
    while true:
        await self.handleEvent()
