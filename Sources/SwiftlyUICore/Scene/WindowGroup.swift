//
//  WindowGroup.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct WindowGroup<Content: View>: Scene {
  let content: Content

  public var body: Never { fatalError() }

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
}
