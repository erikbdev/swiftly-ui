@_spi(Internals)
open class AnyNode {
  #if !hasFeature(Embedded)
    weak var parent: AnyNode?
  #else
    var parent: AnyNode?
  #endif
  var children: [AnyNode] = []
  var environmentValues = EnvironmentValues()
  var root: AnyNode? { parent?.root ?? self }
}
