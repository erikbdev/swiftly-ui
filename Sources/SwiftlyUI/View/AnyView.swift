//
//  AnyView.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct AnyView: View {
  public var content: any View

  public var body: Never { fatalError() }

  public init<T: View>(_ view: T) {
    if let view = view as? AnyView {
      self.content = view.content
    } else {
      self.content = view
    }
  }

  public init<T: View>(erasing view: T) {
    self.init(view)
  }
}

@_spi(Internals)
extension AnyView: PrimitiveView {
  public nonisolated static func _makePrimitiveView(_ node: GraphNode<AnyView>) {}
}
