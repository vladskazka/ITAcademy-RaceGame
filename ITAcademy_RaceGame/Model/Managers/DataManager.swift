//
//  DataManager.swift
//  ITAcademy_RaceGame
//
//  Created by Влад Муравьев on 22.05.2024.
//

import UIKit

enum DataToManage {
    
    case settings
    case results
}

final class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    private let defaultSettings = Settings()
    private var savedSettings: Settings?
    
    func saveData(data: Any?, for dataToSave: DataToManage) {
        
        switch dataToSave {
            
        case .settings:
            let settings = data as? Settings
            UserDefaults.standard.set(encodable: settings, forKey: Constants.settingsKey)
            print("func saveData(), settings - saved to UserDefaults")
        case .results:
            if let results = data as? Result {
                if var resultArray = UserDefaults.standard.value([Result].self, forKey: Constants.resultArrayKey) {
                    resultArray.append(results)
                    UserDefaults.standard.set(encodable: resultArray, forKey: Constants.resultArrayKey)
                } else {
                    UserDefaults.standard.set(encodable: [results], forKey: Constants.resultArrayKey)
                }
            } else {
                print("Failed to save results to UserDefaults")
            }
        }
    }
    
    
    func loadSettings() {
        if let settings = UserDefaults.standard.value(Settings.self, forKey: Constants.settingsKey) {
            savedSettings = settings
        } else {
            savedSettings = defaultSettings
        }
    }
    
    func loadResults() -> [Result]? {
        let resultArray = UserDefaults.standard.value([Result].self, forKey: Constants.resultArrayKey)
        return resultArray
    }
    
    func loadName() -> String {
        if let name = savedSettings?.name {
            return name
        } else {
            return ""
        }
    }
    
    func loadProfileImageName() -> String {
        if let imageName = savedSettings?.profileImageName as? String {
            print("func loadData(), \(imageName) - loaded from UserDefaults")
            return imageName
        } else {
            return defaultSettings.profileImageName
        }
    }
    
    func loadProfileImage() ->  UIImage? {
        if let imageFromFileManager = ImageManager.shared.loadImage(loadProfileImageName()) {
            return imageFromFileManager
        } else {
            let imageName = defaultSettings.profileImageName
            return UIImage(named: imageName)
        }
    }
    
    func loadCarIndex() -> Int {
        if let carIndex = savedSettings?.carIndex {
            return carIndex
        } else {
            return defaultSettings.carIndex
        }
    }
    
    func loadObstacleIndex() -> Int {
        if let obstacleIndex = savedSettings?.obstacleIndex {
            return obstacleIndex
        } else {
            return defaultSettings.obstacleIndex
        }
    }
    
    func loadDifficultyIndex() -> Int {
        if let difficultyIndex = savedSettings?.difficultyIndex {
            return difficultyIndex
        } else {
            return defaultSettings.difficultyIndex
        }
    }
    
}
