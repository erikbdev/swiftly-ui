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
    
//    static func _makeScene()
}

extension Never: Scene {}

extension Scene where Body == Never {
    var body: Never {
        fatalError("Scene bodies cannot be Never")
    }
}
