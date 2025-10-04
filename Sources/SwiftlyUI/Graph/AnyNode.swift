@_spi(Internals)
open class AnyNode {
  weak var parent: AnyNode?
  var children: [AnyNode] = []
  var environmentValues = EnvironmentValues()
  var root: AnyNode? { parent?.root ?? self }
}
