import options, attachment, tables, permissionoverride


type BaseChannel* = ref object of RootObj
  channel_type: string
  id: string

type DirectChannel* = ref object of BaseChannel
  active: bool
  recipients: seq[string]
  last_message_id: Option[string]

type GroupChannel* = ref object of BaseChannel
  name: string
  owner: string
  description: Option[string]
  recipients: seq[string]
  icon: Option[Attachment]
  last_message_id: Option[string]
  permissions: Option[int64]
  nsfw: bool

type TextChannel* = ref object of BaseChannel
  server: string
  name: string
  description: Option[string]
  icon: Option[Attachment]
  last_message_id: Option[string]
  default_permissions: Option[PermissionOverride]
  role_permissions: Table[string, PermissionOverride]
  nsfw: bool

type VoiceChannel* = ref object of BaseChannel
  server: string
  name: string
  description: Option[string]
  icon: Option[Attachment]
  default_permissions: Option[PermissionOverride]
  role_permissions: Table[string, PermissionOverride]
  nsfw: bool
