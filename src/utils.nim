# The default Option provided by std/options just sucks
type
  Option*[T] = object
    case hasValue: bool
    of true:
      value: T
    of false:
      nil
