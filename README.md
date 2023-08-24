# nimrevolt

A Nim wrapper for Revolt Chat API. This is pre-alpha working in progress. Expect missing features and bugs! Please contact us or open new issue if you want to join this project!

Feel free to fork this project and continue working independendly if you want!

# Example code
```nim

import struct/[client, event], asyncdispatch, dotenv, os, strformat, json,
    jsony

load()

when isMainModule:
  if not existsEnv("TOKEN"):
    quit("TOKEN variable is required to run")


  let bot: RevoltClient = newRevoltClient(getEnv("TOKEN"))

  proc onReady(args: JsonNode) =
    echo fmt"I am ready! {bot.users.len} users, {bot.servers.len} servers, {bot.channels.len} channels, {bot.emojis.len} emojis have been cached"

  proc onMessage(args: JsonNode) =
    let message: MessageEvent = fromJson($args, MessageEvent)
    echo message.content

  bot.addRevoltEvent("ready", onReady)
  bot.addRevoltEvent("message", onMessage)

  waitFor bot.login()
```

# Build from source
Make sure to have at least nim 1.6.14 (recommend 2.0.0) in order to compile!

Just simply run `nimble build --verbose` and then run with `nimrevolt` to test!
<br>
<br>
<br>
*This project is licensed under GNU General Public License*