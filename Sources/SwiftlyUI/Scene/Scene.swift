//
//  Scene.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

//@MainActor
//@preconcurrency
public protocol Scene {
  associatedtype Body: Scene

  @SceneBuilder
  //    @MainActor
  //    @preconcurrency
  var body: Self.Body { get }

  static func _makeScene(_ scene: _GraphValue<Self>)
}

extension Scene {
  public static func _makeScene(_ scene: _GraphValue<Self>) {
    // Body._makeScene(_GraphValue<Scene>)
  }
}

extension Never: Scene {}

extension Scene where Body == Never {
  var body: Never {
    fatalError("Scene bodies cannot be Never")
  }
}
