//
//  SceneBuilder.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

@resultBuilder
public enum SceneBuilder {
  public static func buildBlock<Content: Scene>(_ content: Content) -> Content {
    content
  }

  public static func buildExpression<Content: Scene>(_ content: Content) -> Content {
    content
  }
}
