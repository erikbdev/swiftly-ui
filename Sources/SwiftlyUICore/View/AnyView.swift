//
//  AnyView.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct AnyView: View {
    public var content: any View
    
    public var body: Never { fatalError() }
}
