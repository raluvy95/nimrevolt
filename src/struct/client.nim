import event, ws, user, emoji, server, channel, json, asyncdispatch, jsony,
        options, macros

type RevoltClient* = ref object of RootObj
    ws: WebSocket
    token: string
    users*: seq[User]
    servers*: seq[Server]
    emojis*: seq[Emoji]
    channels*: seq[BaseChannel]
    connected*: bool
    events: seq[Event]

macro event*(discord: RevoltClient, fn: untyped): untyped =
    let
        eventName = fn[0]
        params = fn[3]
        pragmas = fn[4]
        body = fn[6]

    var anonFn = newTree(
        nnkLambda,
        newEmptyNode(),
        newEmptyNode(),
        newEmptyNode(),
        params,
        pragmas,
        newEmptyNode(),
        body
    )

    if pragmas.findChild(it.strVal == "async").kind == nnkNilLit:
        anonFn.addPragma ident("async")

    quote:
        `discord`.events.`eventName` = `anonFn`

proc newRevoltClient*(token: string): RevoltClient =
    let websocket = waitFor newWebSocket(
      "wss://ws.revolt.chat?version=1&format=json")
    return RevoltClient(ws: websocket,
        token: token,
        users: @[], servers: @[], emojis: @[], channels: @[], connected: false,
          events: @[])

proc handleEvent(self: RevoltClient) {.async.} =
    let rawJson = await self.ws.receiveStrPacket()
    if rawJson.len >= 1:
        try:
            let json = rawJson.fromJson()
            case json["type"].getStr():
            # TODO handle events
                of "Authenticated":
                    break
                of "Ready":
                    break
                else:
                    break
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
