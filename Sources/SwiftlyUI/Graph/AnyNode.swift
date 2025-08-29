@_spi(Internals)
open class AnyNode {
  weak var parent: AnyNode?
  var children: [AnyNode] = []
  var root: AnyNode? { parent?.root ?? self }

  func logTree(level: Int) -> String { "" }
}
