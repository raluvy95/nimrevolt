# Package

version       = "0.0.1"
author        = "raluvy95"
description   = "A Revolt.chat API wrapper written in Nim"
license       = "MIT"
srcDir        = "src"
bin           = @["test-except-its-example-code"]

# Dependencies

requires "nim >= 1.6.14", "ws >= 0.5.0", "jsony >= 1.1.5", "dotenv >= 2.0.1"
