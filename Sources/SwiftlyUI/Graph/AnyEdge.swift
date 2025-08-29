@_spi(Internals)
open class AnyEdge {
  public var from: AnyNode
  public var to: AnyNode

  public init(from: AnyNode, to: AnyNode) {
    self.from = from
    self.to = to
  }
}
