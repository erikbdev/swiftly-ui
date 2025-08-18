//
//  DefaultBackend.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public final class DefaultBackend: AppBackend {
  public required init() {}

  @MainActor
  override public func runMainLoop(
    _ callback: @escaping @MainActor () -> Void
  ) {
    callback()
  }
}

#if canImport(Testing)
  extension App {
    public typealias Backend = DefaultBackend
  }
#endif
