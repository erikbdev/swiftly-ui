//
//  Spacer.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct Spacer: View {
  public init() {}

  public var body: Never { fatalError() }
}

@_spi(Internals)
extension Spacer: PrimitiveView {
  public nonisolated static func _makeView(_ node: ViewNode<Self>) {}
}
