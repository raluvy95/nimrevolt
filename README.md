# nimrevolt

A Nim wrapper for Revolt Chat API. Working in progress!

# Concept example code
```nim
import nimrevolt, dotenv, os, strutils, asyncdispatch

let client = newRevoltClient(getEnv("TOKEN"))

proc onReady() {.client.event.ready.} =
    echo "I'm ready!"

proc onMessage(message: Message) {.async., .client.event.message.} =
    if message.content.startsWith("!ping"):
        await client.send(message.channel.id, "Pong!")

client.login()

```