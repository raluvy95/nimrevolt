# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.
import unittest, dotenv, nimrevolt, json, strformat, os, asyncdispatch
load()

if not existsEnv("TOKEN"):
    quit("TOKEN env missing")

let token = getEnv("TOKEN")

test "does it run?":
    let bot: RevoltClient = newRevoltClient(token)

    proc onReady(args: JsonNode) =
        echo fmt"I am ready! {bot.users.len} users, {bot.servers.len} servers, {bot.channels.len} channels, {bot.emojis.len} emojis have been cached"
        quit()

    bot.addRevoltEvent("ready", onReady)

    waitFor bot.login()

