//
//  Text.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct Text: View {
  let storage: [_Storage]

  public init(verbatim content: String) {
      self.storage = [_Storage(content: content)]
  }

  public init<S: StringProtocol>(_ content: S) {
      self.storage = [_Storage(content: String(content))]
  }

  init(storage: [_Storage]) {
      self.storage = storage
  }

  public var body: Never { fatalError() }

  var rawText: String { storage.reduce("") { $0 + $1.content } }

  public nonisolated func foregroundStyle<S: ShapeStyle>(_ style: S) -> Text {
    var base = self
    // base.modifiers.append(_ForegroundStyleModifier(AnyShapeStyle(style)))
    return base
  }

  struct _Storage: Hashable {
      let content: String
      // let modifiers: _Modifier
  }
}

@_spi(Internals)
extension Text: PrimitiveView {
  public nonisolated static func _makePrimitiveView(_ node: ViewNode<Self>) {}
}

public func + (lhs: Text, rhs: Text) -> Text {
    Text(storage: lhs.storage + rhs.storage)
}
