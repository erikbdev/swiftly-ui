import Foundation

@_spi(Internals)
open class Node<T>: AnyNode {
  var object: T

  init(_ object: T) {
    self.object = object
  }

  public func appendChild<N: AnyNode>(_ child: N) {
    child.parent = self
    self.children.append(child)
  }
}
