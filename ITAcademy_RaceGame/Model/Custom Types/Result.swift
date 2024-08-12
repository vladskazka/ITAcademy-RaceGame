//
//  Result.swift
//  ITAcademy_RaceGame
//
//  Created by Влад Муравьев on 19.05.2024.
//

import Foundation

final class Result: Codable {
    
    let name: String
    let score: Int
    let date: String
    
    init(name: String, score: Int, date: String) {
        self.name = name
        self.score = score
        self.date = date
    }
}
