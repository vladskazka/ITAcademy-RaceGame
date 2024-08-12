//
//  Settings.swift
//  ITAcademy_RaceGame
//
//  Created by Влад Муравьев on 16.05.2024.
//

import UIKit

final class Settings: Codable {
    
    let name: String
    let profileImageName: String
    let carIndex: Int
    let obstacleIndex: Int
    let difficultyIndex: Int
    
    init(name: String = "", profileImageName: String = ImageNameConstants.profileImage, carIndex: Int = 0, obstacleIndex: Int = 0, difficultyIndex: Int = Constants.defaultSpeed) {
        self.name = name
        self.profileImageName = profileImageName
        self.carIndex = carIndex
        self.obstacleIndex = obstacleIndex
        self.difficultyIndex = difficultyIndex
    }
    
}
