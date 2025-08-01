//
//  iDiceApp.swift
//  iDice
//
//  Created by warren su on 7/31/25.
//
import SwiftData
import SwiftUI

@main
struct iDiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Die.self)
    }
}
