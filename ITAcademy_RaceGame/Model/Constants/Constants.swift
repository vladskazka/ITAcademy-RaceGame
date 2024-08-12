//
//  Constants.swift
//  ITAcademy_RaceGame
//
//  Created by Влад Муравьев on 17.05.2024.
//

import UIKit

enum Constants {
    
        // MARK: - Keys
    
    static let settingsKey = "settings"
    static let resultArrayKey = "result"
    static let profileImageKey = "profile"
    
        // MARK: - Strings
    
    static let back: String = "Back"
    
    static let start: String = "Start"
    static let results: String = "Results"
    static let settings: String = "Settings"
    static let cancel: String = "Cancel"
    
    static let leftArrow: String = "←"
    static let rightArrow: String = "→"
    static let go: String = "Go"
    
    static let upload: String = "Upload"
    static let selectCar: String = "Select your car:"
    static let selectObstacle: String = "Select the obstacle:"
    static let enterName: String = "Enter your name:"
    static let selectDifficulty: String = "Select the difficulty:"
    static let textfieldPlaceholder: String = "Your super cool name"
    
    static let leaderboardLabel: String = "Leaderboard"
    static let positionLabel: String = "#"
    static let nameLabel: String = "Name"
    static let dateLabel: String = "Date"
    static let scoreLabel: String = "Score"
    static let scoreLabelInGame: String = "Score:\n"
    
    static let guest: String = "Guest"
    static let dateFormat: String = "MMM d, yy"

    static let imageSource: String = "Select image source"
    static let camera: String = "Camera"
    static let photoLibrary: String = "Photo Library"
    
        // MARK: - Colors
    
    static let buttonColor: UIColor = UIColor(red: 0.30, green: 0.36, blue: 0.20, alpha: 1.00)
    static let settingBgColor: UIColor = UIColor(red: 0.19, green: 0.22, blue: 0.32, alpha: 1.00)
    static let attributedTextColor: UIColor = UIColor(red: 0.78, green: 0.86, blue: 0.42, alpha: 1.00)
    
        // MARK: - Misc
    
    static let settingsAnimationDuration: Double = 0.3
    static let carMoveAnimation: Double = 0.14
    static let carEngineAnimation: Double = 0.15
    
    static let step: CGFloat = 20
    static let defaultSpeed: Int = 1
    static let counterInitialValue: Int = 3
    
    static let timeIntervalGameOver: Double = 0.01
    static let timeIntervalScoreCount: Double = 0.5
    
    static let contentInsets: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0)
    
    static let attributedTextFont: UIFont? = UIFont(name: "BebasNeue-Regular", size: 40)
    
    static let carImageArray: [String] = [ImageNameConstants.carBlue, ImageNameConstants.carCyan, ImageNameConstants.carGreen, ImageNameConstants.carYellow, ImageNameConstants.carRed, ImageNameConstants.carMcQueen]
    
    static let obstacleImageArray: [String] = [ImageNameConstants.obstacleStone, ImageNameConstants.obstacleCrate, ImageNameConstants.obstacleTrash, ImageNameConstants.obstacleCone, ImageNameConstants.obstacleBanana]
    
    static let difficultyImageArray: [String] = [ImageNameConstants.easy, ImageNameConstants.medium, ImageNameConstants.hard]
}
