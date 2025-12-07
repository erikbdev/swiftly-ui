//
//  EmptyView.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct EmptyView: View {
  public var body: Never { fatalError() }

  @inlinable public init() {}
}

@_spi(Internals)
extension EmptyView: PrimitiveView {
  public nonisolated static func _makeView(_ node: ViewNode<Self>) {}
}
