//
//  iWordleApp.swift
//  iWordle
//
//  Created by warren su on 7/21/25.
//
import SwiftData
import SwiftUI

@main
struct iWordleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: SolveRun.self)
        }
    }
}
