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
    # let author = bot.users.filter(proc (x: User): bool = x.id ==
    #     message.author)
    echo message.content

  bot.addRevoltEvent("ready", onReady)
  bot.addRevoltEvent("message", onMessage)

  waitFor bot.login()

