//
//  Text.swift
//  SwiftlyUI
//
//  Created by erikbdev on 8/14/25.
//

public struct Text: View {
    let text: String
    
    public var body: Never { fatalError() }
    
    init(_ text: String) {
        self.text = text
    }
}
