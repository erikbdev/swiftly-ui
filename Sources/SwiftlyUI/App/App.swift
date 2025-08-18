//
//  App.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

//@MainActor
//@preconcurrency
public protocol App {
  associatedtype Backend: AppBackend
  associatedtype Body: Scene

  @SceneBuilder
  //    @MainActor
  //    @preconcurrency
  var body: Self.Body { get }

  //    @MainActor
  //    @preconcurrency
  init()
}

extension App {
  nonisolated func createBackend() -> Self.Backend {
    Self.Backend()
  }
}

extension App {
  public static func main() {
    let app = Self()

  }
}
