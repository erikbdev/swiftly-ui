//
//  Divider.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct Divider: View {
  public init() {}

  public var body: Never { fatalError() }
}

@_spi(Internals)
extension Divider: PrimitiveView {
  public nonisolated static func _makeView(_ node: Node<Self>) {}
}
