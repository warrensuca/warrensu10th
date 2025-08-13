//
//  SolveRun.swift
//  iWordle
//
//  Created by warren su on 8/12/25.
//
import SwiftData
import Foundation

@Model
class SolveRun{
    var attempts: Int
    var wordDisplays = [[String: [Int]]]()
    var date = Date()
    
    
    init(attempts: Int, wordDisplays: [[String: [Int]]]){
        self.attempts = attempts
        self.wordDisplays = wordDisplays
        self.date = Date()
    }
    
}
