import Foundation

public final class Node<V: View> {
  var view: V

  init(_ view: V) {
    self.view = view
  }

  weak var parent: Node?

  var childen: [Node] = []
  var uuid = UUID()
  var root: Node { parent?.root ?? self }

  func logTree(level: Int = 0) -> String {
    let indent = Array(repeating: " ", count: level * 2)
      .joined()

    var string = ""
    string += "\(indent)→ \(type(of: self.view))"
    for child in childen {
      string += "\n" + child.logTree(level: level + 1)
    }
    return string
  }
}
