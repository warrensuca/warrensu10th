//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Warren Su on 7/28/25.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
