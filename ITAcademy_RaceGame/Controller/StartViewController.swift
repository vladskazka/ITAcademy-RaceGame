//
//  StartViewController.swift
//  ITAcademy_RaceGame
//
//  Created by Влад Муравьев on 01.05.2024.
//

import UIKit
import SnapKit

private enum Direction {
    case left
    case right
}

private enum CarSpawn {
    case oppositeLine
    case directionLane
}

class StartViewController: UIViewController {
    
    private let loadSettings: Any? = {
        DataManager.shared.loadSettings()
        return nil
    }()
    
    // MARK: - Properties: Containers
    
    private let counterView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        return view
    }()
    
    private let controlContainer = UIView()
    
    // MARK: - Properties: Labels
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: CGFloat.countdownFontSize, weight: .black)
        label.alpha = .zero
        return label
    }()
    
    private let scoreCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: CGFloat.scoreTextSize, weight: .medium)
        return label
    }()
    
    // MARK: - Properties: Buttons
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.back, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat.fontSize)
        return button
    }()
    
    private let leftArrowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.setTitle(Constants.leftArrow, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat.arrowSize, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        return button
    }()
    
    private let rightArrowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.setTitle(Constants.rightArrow, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat.arrowSize, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        return button
    }()
    
    // MARK: - Properties: Images
    
    private let backgroundRoadView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageNameConstants.road)
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let mainCarView: UIImageView = {
        let image = UIImageView()
        let index = DataManager.shared.loadCarIndex()
        image.image = UIImage(named: Constants.carImageArray[index])
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let secondaryCar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageNameConstants.secondaryCar)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let secondaryCar2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageNameConstants.secondaryCar)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let boomView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageNameConstants.boom)
        image.isHidden = true
        return image
    }()
    
    private let obstacleLeftView: UIImageView = {
        let image = UIImageView()
        let index = DataManager.shared.loadObstacleIndex()
        image.image = UIImage(named: Constants.obstacleImageArray[index])
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let obstacleRightView: UIImageView = {
        let image = UIImageView()
        let index = DataManager.shared.loadObstacleIndex()
        image.image = UIImage(named: Constants.obstacleImageArray[index])
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let frontLeftTurnSignal: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageNameConstants.turnSignal)
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    private let frontRightTurnSignal: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageNameConstants.turnSignal)
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    private let rearLeftTurnSignal: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageNameConstants.turnSignal)
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    private let rearRightTurnSignal: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageNameConstants.turnSignal)
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    // MARK: - Properties: Logic
    
    private var timer = Timer()
    
    private var carPositionX: CGFloat = .offsetFromMiddle
    private var carSpawn: [CarSpawn] = [.directionLane, .oppositeLine]
    
    private var isGameStarted: Bool = false
    private var isGameOver: Bool = false
    
    private var counter: Int = Constants.counterInitialValue
    private var score: Int = .zero
    private var playerName: String = DataManager.shared.loadName()
    
    private let gameSpeed: Double = {
        let speed = DataManager.shared.loadDifficultyIndex()
        switch speed {
        case 3:
            return 1.5
        case 2:
            return 1.25
        default:
            return 1.0
        }
    }()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(gameSpeed)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        leftArrowButton.layer.cornerRadius = leftArrowButton.frame.height / 5
        rightArrowButton.layer.cornerRadius = rightArrowButton.frame.height / 5
        
        startCounter()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        boomView.alpha = .zero
        isGameOver = true
    }
    
    // MARK: - UI Setup Functions
    
    private func setupUI() {
        
        view.addSubview(backgroundRoadView)
        
        backgroundRoadView.addSubview(obstacleLeftView)
        backgroundRoadView.addSubview(obstacleRightView)
        
        view.addSubview(frontLeftTurnSignal)
        view.addSubview(frontRightTurnSignal)
        view.addSubview(rearLeftTurnSignal)
        view.addSubview(rearRightTurnSignal)
        view.addSubview(mainCarView)
        
        mainCarView.addSubview(boomView)
        backgroundRoadView.addSubview(secondaryCar)
        
        backgroundRoadView.addSubview(controlContainer)
        controlContainer.addSubview(leftArrowButton)
        controlContainer.addSubview(rightArrowButton)
        controlContainer.addSubview(scoreCount)
        
        view.addSubview(counterView)
        counterView.addSubview(label)
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.backButtonLeftOffset)
            make.top.equalToSuperview().offset(CGFloat.backButtonTopOffset)
        }
        
        let backButtonAction = UIAction { _ in
            self.backButtonPressed()
        }
        
        backButton.addAction(backButtonAction, for: .touchUpInside)
        
        backgroundRoadView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        controlContainer.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(CGFloat.controlContainerHeight)
        }
        
        leftArrowButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.offset10)
            make.bottom.equalToSuperview().inset(CGFloat.offset30)
            make.centerX.equalToSuperview().offset(-CGFloat.offsetFromMiddle)
            make.height.equalTo(leftArrowButton.snp.width)
        }
        
        let leftAction = UIAction { _ in
            self.moveCar(direction: .left)
        }
        
        leftArrowButton.addAction(leftAction, for: .touchUpInside)
        
        rightArrowButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.offset10)
            make.bottom.equalToSuperview().inset(CGFloat.offset30)
            make.centerX.equalToSuperview().offset(CGFloat.offsetFromMiddle)
            make.height.equalTo(rightArrowButton.snp.width)
        }
        
        let rightButtonAction = UIAction { _ in
            self.moveCar(direction: .right)
        }
        
        rightArrowButton.addAction(rightButtonAction, for: .touchUpInside)
        
        scoreCount.snp.makeConstraints { make in
            make.left.equalTo(rightArrowButton.snp.right).offset(CGFloat.offset30)
            make.right.equalToSuperview().inset(CGFloat.offset10)
            make.bottom.equalTo(rightArrowButton.snp.bottom).inset(CGFloat.offset15)
            make.top.equalTo(rightArrowButton.snp.top).inset(CGFloat.offset15)
        }
        
        obstacleLeftView.frame.size = CGSize(width: CGFloat.obstacleSize, height: CGFloat.obstacleSize)
        obstacleLeftView.frame.origin.x = .zero
        obstacleLeftView.frame.origin.y = .zero
        
        obstacleRightView.frame.size = CGSize(width: CGFloat.obstacleSize, height: CGFloat.obstacleSize)
        obstacleRightView.frame.origin.x = view.frame.width - obstacleRightView.frame.width
        obstacleRightView.frame.origin.y = -CGFloat.obstacleDestinationOffset
        
        
        frontLeftTurnSignal.snp.makeConstraints { make in
            make.width.height.equalTo(CGFloat.signalSize)
            make.left.equalTo(mainCarView.snp.left).offset(-CGFloat.frontSignalOffsetX)
            make.top.equalTo(mainCarView.snp.top).offset(-CGFloat.frontSignalOffsetY)
        }
        
        frontRightTurnSignal.snp.makeConstraints { make in
            make.width.height.equalTo(CGFloat.signalSize)
            make.right.equalTo(mainCarView.snp.right).offset(CGFloat.frontSignalOffsetX)
            make.top.equalTo(mainCarView.snp.top).offset(-CGFloat.frontSignalOffsetY)
        }
        
        rearLeftTurnSignal.snp.makeConstraints { make in
            make.width.height.equalTo(CGFloat.signalSize)
            make.left.equalTo(mainCarView.snp.left).offset(-CGFloat.rearSignalOffsetX)
            make.bottom.equalTo(mainCarView.snp.bottom).offset(CGFloat.rearSignalOffsetY)
        }
        
        rearRightTurnSignal.snp.makeConstraints { make in
            make.width.height.equalTo(CGFloat.signalSize)
            make.right.equalTo(mainCarView.snp.right).offset(CGFloat.rearSignalOffsetX)
            make.bottom.equalTo(mainCarView.snp.bottom).offset(CGFloat.rearSignalOffsetY)
        }
        
        mainCarView.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.carWidth)
            make.height.equalTo(CGFloat.carHeight)
            make.centerX.equalToSuperview().offset(CGFloat.offsetFromMiddle)
            make.bottom.equalTo(controlContainer.snp.top).offset(-CGFloat.offset5)
        }
        
        secondaryCar.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.carWidth)
            make.height.equalTo(CGFloat.carHeight)
            make.centerX.equalToSuperview().offset(-CGFloat.offsetFromMiddle)
            make.top.equalToSuperview().offset(CGFloat.offset50)
        }
        
        boomView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(CGFloat.boomSize)
        }
        
        counterView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - UIButton Functions
    
    private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Flow Functions
    
    private func startGame() {
        startCheckingIfGameIsOver()
        startUpdatingScoreCount()
        moveSecondaryCar()
        moveLeftStone()
        moveRightStone()
        animateCarEngine(car: mainCarView)
        checkIfCarCrash()
    }
    
    private func moveCar(direction: Direction) {
        
        if !isGameOver {
            
            switch direction {
                
            case .left:
                carPositionX -= Constants.step
                recalculateCarConstrains()
                showTurnSignals(left: true)
            case .right:
                carPositionX += Constants.step
                recalculateCarConstrains()
                showTurnSignals(right: true)
            }
        }
    }
    
    private func saveResult() {
        
        if playerName == "" {
            playerName = Constants.guest
        }
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        
        let dateString = formatter.string(from: currentDate)
        
        let currentResult = Result(name: playerName, score: score, date: dateString)
        
        DataManager.shared.saveData(data: currentResult, for: .results)
    }
    
    // MARK: - Game Logic Functions
    
    private func startCounter() {
        
        label.transform = CGAffineTransform(scaleX: 3, y: 3)
        
        UIView.animate(withDuration: 1) {
            
            self.label.alpha = 1
            self.label.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            if self.counter == .zero {
                self.label.text = Constants.go
            } else {
                self.label.text = String(self.counter)
            }
            
        } completion: { _ in
            
            self.counter -= 1
            self.label.alpha = .zero
            if self.counter < .zero {
                self.counterView.removeFromSuperview()
                self.startGame()
            } else {
                self.startCounter()
            }
        }
    }
    
    private func startCheckingIfGameIsOver() {
        
        timer = Timer.scheduledTimer(withTimeInterval: Constants.timeIntervalGameOver, repeats: true, block: { timer in
            
            self.checkIfCarCrash()
            self.checkIfCrashedIntoStones()
            
            if self.isGameOver {
                self.saveResult()
                self.boomView.isHidden = false
                self.nukeAllAnimations()
                self.stopAllObjects()
                timer.invalidate()
            }
        })
        
        timer.fire()
    }
    
    private func startUpdatingScoreCount() {
        
        timer = Timer.scheduledTimer(withTimeInterval: Constants.timeIntervalScoreCount / gameSpeed, repeats: true, block: { timer in
            
            if !self.isGameOver {
                self.score += 1
                self.scoreCount.text = Constants.scoreLabelInGame + String(self.score)
            }
        })
        
        timer.fire()
    }
    
    private func checkIfMoveIsAllowed() {
        
        if mainCarView.frame.origin.x < view.frame.origin.x + CGFloat.dangerousRoadside {
            isGameOver = true
        } else if mainCarView.frame.origin.x > view.frame.width - mainCarView.frame.width - CGFloat.dangerousRoadside {
            isGameOver = true
        }
    }
    
    private func checkIfCrashedIntoStones() {
        
        // Right Stone
        if let rightStoneFrame = obstacleRightView.layer.presentation()?.frame {
            if mainCarView.frame.intersects(rightStoneFrame) {
                isGameOver = true
            }
        }
        
        // Left Stone
        if let leftStoneFrame = obstacleLeftView.layer.presentation()?.frame {
            if mainCarView.frame.intersects(leftStoneFrame) {
                isGameOver = true
            }
        }
    }
    
    private func checkIfCarCrash() {
        
        guard let frame = self.secondaryCar.layer.presentation()?.frame else { return }
        let collision = frame.intersects(self.mainCarView.frame)
        if collision {
            self.isGameOver = true
        }
    }
    
    // MARK: - Animation Functions
    
    private func recalculateCarConstrains() {
        
        mainCarView.snp.updateConstraints { make in
            make.centerX.equalToSuperview().offset(carPositionX)
        }
        
        UIView.animate(withDuration: Constants.carMoveAnimation) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.checkIfMoveIsAllowed()
        }
    }
    
    private func moveSecondaryCar() {
        
        if !isGameOver {
            
            UIView.animate(withDuration: TimeInterval(7 / gameSpeed)) {
                self.secondaryCar.frame.origin.y += self.view.frame.height * CGFloat.random(in: 2...3)
            } completion: { _ in
                self.secondaryCar.frame.origin.y = self.view.frame.origin.y - self.secondaryCar.frame.height * CGFloat.random(in: 2...3)
                
                let randomSpawn = self.carSpawn.randomElement()
                let carWidthOffset = self.secondaryCar.frame.width / 2
                
                switch randomSpawn {
                case .oppositeLine:
                    self.secondaryCar.frame.origin.x = self.backgroundRoadView.frame.midX - CGFloat.offsetFromMiddle - carWidthOffset
                case .directionLane:
                    self.secondaryCar.frame.origin.x = self.backgroundRoadView.frame.midX + CGFloat.offsetFromMiddle - carWidthOffset
                case .none:
                    return
                }
                
                self.moveSecondaryCar()
            }
        }
    }
    
    private func moveLeftStone() {
        UIView.animate(withDuration: TimeInterval(7 / gameSpeed)) {
            
            self.obstacleLeftView.frame.origin.y = self.view.frame.height + CGFloat.obstacleDestinationOffset
            
        } completion: { _ in
            
            let top = self.view.frame.origin.y
            
            if !self.isGameOver {
                
                self.obstacleLeftView.frame.origin.y = top - self.obstacleLeftView.frame.height
                
                self.moveLeftStone()
            }
        }
    }
    
    private func moveRightStone() {
        
        UIView.animate(withDuration: TimeInterval(7 / gameSpeed)) {
            
            self.obstacleRightView.frame.origin.y = self.view.frame.height
            
        } completion: { _ in
            
            let top = self.view.frame.origin.y
            
            if !self.isGameOver {
                
                self.obstacleRightView.frame.origin.y = top - self.obstacleRightView.frame.height - CGFloat.obstacleDestinationOffset
                
                self.moveRightStone()
            }
        }
    }
    
    private func showTurnSignals(left leftBool: Bool = false, right rightBool: Bool = false) {
        frontLeftTurnSignal.isHidden = rightBool
        rearLeftTurnSignal.isHidden = rightBool
        frontRightTurnSignal.isHidden = leftBool
        rearRightTurnSignal.isHidden = leftBool
    }
    
    private func animateCarEngine(car: UIImageView) {
        
        if !isGameOver {
            UIView.animate(withDuration: Constants.carEngineAnimation) {
                car.frame.size.width = CGFloat.carWidth * 1.015
                car.frame.size.height = CGFloat.carHeight * 1.015
            } completion: { _ in
                self.animateCarEngine(car: car)
            }
        }
    }
    
    private func stopAllObjects() {
        
        if let leftStone = self.obstacleLeftView.layer.presentation()?.frame, let rightStone = self.obstacleRightView.layer.presentation()?.frame, let frame = self.secondaryCar.layer.presentation()?.frame {
            
            self.obstacleLeftView.frame = leftStone
            self.obstacleRightView.frame = rightStone
            
            self.secondaryCar.removeFromSuperview()
            self.backgroundRoadView.addSubview(self.secondaryCar2)
            self.secondaryCar2.frame = frame
        }
    }
    
    private func nukeAllAnimations() {
        self.backgroundRoadView.subviews.forEach({$0.layer.removeAllAnimations()})
        self.backgroundRoadView.layer.removeAllAnimations()
        self.backgroundRoadView.layoutIfNeeded()
    }
}


