//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Warren Su on 7/18/25.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Book.self)
    }
}
