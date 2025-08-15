//
//  SceneGraph.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

final class _SceneGraph<AppRoot: App> {
    let app: AppRoot
    let backend: AppRoot.Backend
    
    init(_ app: AppRoot) {
        self.app = app
        self.backend = app.createBackend()
    }
    
    @MainActor
    func run() {
        backend.runMainLoop {}
    }
}
