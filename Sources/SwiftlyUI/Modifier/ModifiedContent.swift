//
//  ModifiedContent.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/25/25.
//

public struct ModifiedContent<Content, Modifier> {
  public typealias Body = Never

  public var content: Content
  public var modifier: Modifier

  public nonisolated init(content: Content, modifier: Modifier) {
    self.content = content
    self.modifier = modifier
  }
}

extension ModifiedContent: Equatable where Content: Equatable, Modifier: Equatable {}

public struct EmptyModifier: ViewModifier {
  public typealias Body = Never

  public func body(content: Content) -> Never { fatalError() }
}
