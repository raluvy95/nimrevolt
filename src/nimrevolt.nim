import struct/[client, event], asyncdispatch, json, dotenv, os
load()

when isMainModule:
  if not existsEnv("TOKEN"):
    quit("TOKEN variable is required to run")
  let bot = newRevoltClient(getEnv("TOKEN"))

  #TODO handle event too


  waitFor bot.login()

