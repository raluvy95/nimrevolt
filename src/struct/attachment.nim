import options

type Metadata = ref object
  `type`: string
  width: Option[int]
  height: Option[int]

type Attachment* = ref object of RootObj
  id*: string
  tag*: string
  filename*: string
  metadata*: Metadata
  content_type*: string
  size*: int
  deleted*: Option[bool]
  reported*: Option[bool]
  message_id*: Option[string]
  user_id*: Option[string]
  server_id*: Option[string]
  object_id*: Option[string]
