//
//  ForEach.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct ForEach<Data, ID, Content> where Data: RandomAccessCollection, ID: Hashable {
  public var data: Data
  public var content: (Data.Element) -> Content

  var body: Never { fatalError() }
}
