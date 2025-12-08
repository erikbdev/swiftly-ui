//
//  Text.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct Text: View {
  let storage: [_Storage]

  public init(verbatim content: String) {
    self.storage = [_Storage(content: content, modifiers: [])]
  }

  public init<S: StringProtocol>(_ content: S) {
    self.init(verbatim: String(content))
  }

  init(_ storage: [_Storage]) {
    self.storage = storage
  }

  public var body: Never { fatalError() }

  var stringValue: String { storage.reduce("") { $0 + $1.content } }

  public nonisolated func foregroundStyle<S: ShapeStyle>(_ style: S) -> Text {
    var base = self
    // base.modifiers.append(_ForegroundStyleModifier(AnyShapeStyle(style)))
    return base
  }

  public nonisolated func font(_ font: Font) -> Text {
    var base = self
    return base
  }

  struct _Storage {
    let content: String
    let modifiers: [_Modifier]

    enum _Modifier {
      case foregroundStyle(AnyShapeStyle)
      case font(Font)
    }
  }
}

@_spi(Internals)
extension Text: PrimitiveView {
  public nonisolated static func _makeView(_ node: Node<Self>) { }
}

public func + (lhs: Text, rhs: Text) -> Text {
  Text(lhs.storage + rhs.storage)
}
