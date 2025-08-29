//
//  WindowGroup.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct WindowGroup<Content: View>: Scene {
  let content: Content

  public var body: Never { sceneBodyNever() }

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
}

@_spi(Internals)
extension WindowGroup: PrimitiveScene {
  public static func _makePrimitiveScene(_ node: Node<Self>) {
    Content._makeView(node[\.content])
  }
}
