import options, permissionoverride, attachment

type ServerCategory = object
  id: string
  title: string
  channels: seq[string]

type ServerSystemMessages = object
  user_joined: Option[string]
  user_left: Option[string]
  user_kicked: Option[string]
  user_banned: Option[string]

type ServerRole* = ref object
  name: string
  permissions: PermissionOverride
  colour: Option[string]
  hoist: bool
  rank: int64


type Server* = ref object
  id*: string
  owner*: string
  name*: string
  description*: Option[string]
  channels*: seq[string]
  categories*: Option[seq[ServerCategory]]
  system_messages*: Option[ServerSystemMessages]
  default_permissions*: int64
  icon*: Option[Attachment]
  banner*: Option[Attachment]
  flags*: Option[int32]
  nsfw*: bool
  analytics*: bool
  discoverable*: bool
