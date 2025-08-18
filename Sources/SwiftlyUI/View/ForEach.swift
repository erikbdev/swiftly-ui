//
//  ForEach.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct ForEach<Data: RandomAccessCollection, ID: Hashable, Content> {
  public var data: Data
  public var idKeyPath: KeyPath<Data.Element, ID>
  public var content: (Data.Element) -> Content

  public var body: Never { fatalError() }

  public init(
    _ data: Data,
    id keyPath: KeyPath<Data.Element, ID>,
    @ViewBuilder content: @escaping (Data.Element) -> Content
  ) {
    self.data = data
    self.idKeyPath = keyPath
    self.content = content
  }

  public init(
    _ data: Data,
    @ViewBuilder content: @escaping (Data.Element) -> Content
  ) where Data.Element: Identifiable, Data.Element.ID == ID {
    self.init(data, id: \Data.Element.id, content: content)
  }
}

extension ForEach: View where Content: View {}
