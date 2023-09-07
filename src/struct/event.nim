import emoji, options, json, user, server, channel, asyncdispatch

type
  Args* = ref object of RootObj


type ResponseEvent* = ref object of Args
  `type`*: string

type Event* = ref object
  name*: string
  handler*: proc (args: JsonNode) {.async.}



type ReadyEvent* = ref object of ResponseEvent
  users*: seq[User]
  servers*: seq[Server]
  channels*: seq[BaseChannel]
  emojis*: Option[seq[Emoji]]

type UserUpdateEvent* = ref object of ResponseEvent
  id*: string
  data*: JsonNode
  clear*: seq[string]

type MessageEvent* = ref object of ResponseEvent
  id*: string
  nonce*: string
  channel*: string
  author*: string
  content*: string

type RawEvent* = ref object of ResponseEvent
  data*: JsonNode


proc `$`*(e: ResponseEvent): string =
  return e.`type`

proc `$`*(e: Event): string =
  return e.name
