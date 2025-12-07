//
//  Toggle.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct Toggle<Label: View>: View {
  public var isOn: Binding<Bool>
  public var label: Label

  public var body: Never { fatalError() }

  public init(isOn: Binding<Bool>, @ViewBuilder label: () -> Label) {
    self.isOn = isOn
    self.label = label()
  }

  public init(isOn: Binding<Bool>) where Label == EmptyView {
    self.init(isOn: isOn, label: EmptyView.init)
  }
}

@_spi(Internals)
extension Toggle: PrimitiveView {
  public nonisolated static func _makeView(_ node: ViewNode<Self>) {
    node.appendChild(ViewNode(node.view.label))
  }
}

public struct ToggleStyle: Sendable {
  public static let `switch` = Self()
  public static let button = Self()
  public static let checkbox = Self()
}
