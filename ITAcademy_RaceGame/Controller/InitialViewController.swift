//
//  ViewController.swift
//  ITAcademy_RaceGame
//
//  Created by Влад Муравьев on 01.05.2024.
//

import UIKit
import SnapKit

class InitialViewController: UIViewController {

    // MARK: - Properties: Images
    
    private let backgroundView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageNameConstants.background)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Properties: Buttons
    
    private let startButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.contentInsets = Constants.contentInsets
        button.configuration = configuration
        button.setAttributedTitle(Constants.start.makeAttributed(), for: .normal)
        button.tintColor = Constants.buttonColor
        return button
    }()
    
    private let resultsButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.contentInsets = Constants.contentInsets
        button.configuration = configuration
        button.setAttributedTitle(Constants.results.makeAttributed(), for: .normal)
        button.tintColor = Constants.buttonColor
        return button
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.contentInsets = Constants.contentInsets
        button.configuration = configuration
        button.setAttributedTitle(Constants.settings.makeAttributed(), for: .normal)
        button.tintColor = Constants.buttonColor
        return button
    }()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.loadSettings()
        setupUI()
    }
    
    // MARK: - Flow Functions
    
    private func setupUI() {
        
        view.addSubview(backgroundView)
        view.addSubview(startButton)
        view.addSubview(resultsButton)
        view.addSubview(settingsButton)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.height.equalTo(resultsButton.snp.height)
            make.left.equalTo(resultsButton.snp.left)
            make.right.equalTo(resultsButton.snp.right)
            make.bottom.equalTo(resultsButton.snp.top).offset(-CGFloat.menuButtonPadding)
        }
        
        let startButtonAction = UIAction { _ in
            self.startButtonPressed()
        }
        
        startButton.addAction(startButtonAction, for: .touchUpInside)
        
        resultsButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(CGFloat.menuButtonSideOffset)
            make.right.equalToSuperview().inset(CGFloat.menuButtonSideOffset)
            make.height.equalTo(CGFloat.menuButtonHeight)
        }
        
        let resultButtonAction = UIAction { _ in
            self.resultsButtonPressed()
        }
        
        resultsButton.addAction(resultButtonAction, for: .touchUpInside)
        
        settingsButton.snp.makeConstraints { make in
            make.height.equalTo(resultsButton.snp.height)
            make.left.equalTo(resultsButton.snp.left)
            make.right.equalTo(resultsButton.snp.right)
            make.top.equalTo(resultsButton.snp.bottom).offset(CGFloat.menuButtonPadding)
        }
        
        let settingsButtonAction = UIAction { _ in
            self.settingsButtonPressed()
        }
        
        settingsButton.addAction(settingsButtonAction, for: .touchUpInside)
        
    }
    
    // MARK: - UIButton Functions
    
    private func startButtonPressed() {
        let controller = StartViewController()
    
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func resultsButtonPressed() {
        let controller = ResultsViewController()
    
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func settingsButtonPressed() {
        let controller = SettingsViewController()
    
        navigationController?.pushViewController(controller, animated: true)
    }
}
