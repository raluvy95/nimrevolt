when isMainModule:
  import asyncdispatch, dotenv, os, strformat, json, jsony, ../src/nimrevolt
  load()

  if not existsEnv("TOKEN"):
    quit("TOKEN variable is required to run")


  let bot: RevoltClient = newRevoltClient(getEnv("TOKEN"))

  proc onReady(args: JsonNode) =
    echo fmt"I am ready! {bot.users.len} users, {bot.servers.len} servers, {bot.channels.len} channels, {bot.emojis.len} emojis have been cached"

  proc onMessage(args: JsonNode) =
    let message: MessageEvent = fromJson($args, MessageEvent)
    echo bot.users.len()
    echo "Someone sent a message - " & message.content

  proc onRawEvent(args: JsonNode) =
    echo $args

  bot.addRevoltEvent("ready", onReady)
  bot.addRevoltEvent("message", onMessage)
  bot.addRevoltEvent("raw", onRawEvent)

  waitFor bot.login()
