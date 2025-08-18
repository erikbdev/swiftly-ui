//
//  ViewModifier.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public protocol ViewModifier {
  associatedtype Body: View
  typealias Content = _ViewModifier_Content<Self>

  @ViewBuilder
  func body(content: Self.Content) -> Self.Body
}

public struct _ViewModifier_Content<Modifier: ViewModifier>: View {
  public typealias Body = Never

  public var body: Never { fatalError() }
}

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

extension ModifiedContent: View where Content: View, Modifier: ViewModifier, Modifier.Body == Never {
  public var body: Never { fatalError() }

  // TODO: Add this modifier's properties as part of the view that is attached to.
}

public struct EmptyModifier: ViewModifier {
  public typealias Body = Never

  public func body(content: Content) -> Never { fatalError() }
}

extension Never: ViewModifier {
  public typealias Body = Never

  public func body(content: Content) -> Never { fatalError() }
}

extension View {
  public nonisolated func modifier<T>(_ modifier: T) -> ModifiedContent<Self, T> {
    ModifiedContent(content: self, modifier: modifier)
  }
}
