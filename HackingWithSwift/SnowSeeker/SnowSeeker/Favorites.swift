//
//  Favorites.swift
//  SnowSeeker
//
//  Created by warren su on 8/1/25.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    
    private let key = "Favorites"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = decoded
                return
            }
        }
        
        resorts = []
    }
    
    func contains(_ resort : Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(resorts) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
