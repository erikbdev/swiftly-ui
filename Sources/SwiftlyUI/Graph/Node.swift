import Foundation

@_spi(Internals)
public class Node<V>: AnyNode {
  let object: V

  public init(_ object: V) {
    self.object = object
  }

  func insertChild<N: AnyNode>(_ child: N) {
    child.parent = self
    self.children.append(child)
  }

  public override func logTree(level: Int = 0) -> String {
    guard level == 0 else {
      var string = ""
      string += "\"\(V.self)\""
      for child in children {
        string += "\n\"\(V.self)\" -> \(child.logTree(level: level + 1))"
      }
      return string
    }
    var string = "digraph {"
    string += "\n"
    for child in children {
      string += "\n\"\(V.self)\" -> \(child.logTree(level: level + 1))"
    }
    return string + "\n}"
  }
}
