import emoji, options, json, user, server, channel

type
  Args* = ref object of RootObj
  Event* = tuple[name: string, handlers: seq[Handler]] # key value pair
  Handler* = proc (args: Args) {.closure.} # callback function type

type ResponseEvent* = object of Args
  `type`*: string


type ReadyEvent* = ref object of ResponseEvent
  users*: seq[User]
  servers*: seq[Server]
  channels*: seq[BaseChannel]
  emojis*: Option[seq[Emoji]]

type UserUpdateEvent* = ref object of ResponseEvent
  id*: string
  data*: JsonNode
  clear*: seq[string]

type RawEvent* = ref object of Args
  data*: JsonNode
