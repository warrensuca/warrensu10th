//
//  InstaFilterApp.swift
//  InstaFilter
//
//  Created by warren su on 7/23/25.
//

import SwiftUI

@main
struct InstaFilterApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: InstaFilterDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
