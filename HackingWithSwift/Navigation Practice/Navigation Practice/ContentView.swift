//
//  ContentView.swift
//  Navigation Practice
//
//  Created by warren su on 7/10/25.
//

import SwiftUI


struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
}


@Observable
class PathStore {
    var path: [Int] {
        didSet {
            save()
        }
    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
                path = decoded
                return
            }
        }

        // Still here? Start with an empty path.
        path = []
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(path)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}
struct ContentView: View {
    @State private var path = [Int]()
    var body: some View {
        NavigationStack(path: $path) {
            List(0..<100) { i in
                NavigationLink("Select \(i)", value: i)
            }
            
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
            .navigationDestination(for: Student.self) {
                selection in
                Text("You selected \(selection.name)")
            }

            }
            
        }
    }
}

#Preview {
    ContentView()
}
