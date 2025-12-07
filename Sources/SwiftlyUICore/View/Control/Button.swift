//
//  Button.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct Button<Label: View>: View {
  public var action: () -> Void
  public var label: Label

  public var body: Never { fatalError() }

  public init(action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) {
    self.action = action
    self.label = label()
  }

  public init(_ text: String, action: @escaping () -> Void) where Label == Text {
    self.action = action
    self.label = Text(text)
  }
}

@_spi(Internals)
extension Button: PrimitiveView {
  public nonisolated static func _makeView(_ node: ViewNode<Self>) {
    node.appendChild(ViewNode(node.view.label))
  }
}
