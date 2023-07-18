type EmojiParent = object
  `type`: string
  id: string

type Emoji* = ref object
  id: string
  parent: EmojiParent
  creator_id: string
  name: string
  animated: bool
  nsfw: bool
