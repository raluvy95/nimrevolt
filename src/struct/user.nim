import options, attachment

type UserRelation* = object of RootObj
  id*: string
  status*: string

type UserStatus* = object of RootObj
  text*: Option[string]
  presence*: Option[string]

type UserProfile* = object of RootObj
  content: Option[string]
  background: Option[Attachment]

type UserBot = ref object
  owner: string

type User* = object of RootObj
  id*: string
  username*: string
  discriminator*: string
  display_name*: Option[string]
  avatar*: Option[Attachment]
  relations*: Option[seq[UserRelation]]
  badges*: Option[int32]
  status*: Option[UserStatus]
  profile*: Option[UserProfile]
  flags*: Option[int32]
  bot*: Option[UserBot]
  relationship*: Option[string]
  online*: Option[bool]


