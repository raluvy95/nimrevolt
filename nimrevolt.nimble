# Package

version       = "0.0.1"
author        = "raluvy95"
description   = "A Revolt API wrapper written in Nim"
license       = "MIT"
srcDir        = "src"
bin           = @["nimrevolt"]

# Dependencies

requires "nim >= 1.6.14", "ws >= 0.5.0", "jsony >= 1.1.5", "dotenv >= 2.0.1"
