//
//  Favorites.swift
//  SnowSeeker
//
//  Created by warren su on 8/1/25.
//
import SwiftData
import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    
    private let key = "Favorites"
    
    init() {
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
        
    }
}
