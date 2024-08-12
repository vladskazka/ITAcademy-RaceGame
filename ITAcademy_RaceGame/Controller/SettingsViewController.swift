//
//  SettingsViewController.swift
//  ITAcademy_RaceGame
//
//  Created by Влад Муравьев on 01.05.2024.
//

import UIKit

private enum ArrowDirection {
    case leftTop
    case rightTop
    case leftMiddle
    case rightMiddle
    case leftBottom
    case rightBottom
}

// MARK: - View Controller

class SettingsViewController: UIViewController, UITextFieldDelegate {
        
    private let loadSettings: Int = {
        DataManager.shared.loadSettings()
        return 0
    }()
    
    // MARK: - Properties: Containers

    private let topContainer = UIView()
    private let profileContainer = UIView()
    private let nameContainer = UIView()
    private let carContainer = UIView()
    private let obstacleContainer = UIView()
    private let difficultyContainer = UIView()
    
    // MARK: - Properties: Labels
    
    private let carLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.selectCar
        label.textColor = .white
        label.font = .monospacedSystemFont(ofSize: CGFloat.fontSize, weight: .semibold)
        return label
    }()
    
    private let obstacleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.selectObstacle
        label.textColor = .white
        label.font = .monospacedSystemFont(ofSize: CGFloat.fontSize, weight: .semibold)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.enterName
        label.textColor = .white
        label.font = .monospacedSystemFont(ofSize: CGFloat.fontSize, weight: .semibold)
        return label
    }()
    
    private let difficultyLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.selectDifficulty
        label.textColor = .white
        label.font = .monospacedSystemFont(ofSize: CGFloat.fontSize, weight: .semibold)
        return label
    }()
    
    // MARK: - Properties: TextField

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = Constants.textfieldPlaceholder
        textField.text = DataManager.shared.loadName()
        textField.autocorrectionType = .no
        textField.font = .systemFont(ofSize: CGFloat.fontSize, weight: .bold)
        return textField
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
    
    private let uploadButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = Constants.upload
        button.configuration?.baseForegroundColor =  Constants.settingBgColor
        button.tintColor = .systemYellow
        return button
    }()
    
    private let leftArrowButtonTop: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNameConstants.leftArrow), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let rightArrowButtonTop: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNameConstants.rightArrow), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let leftArrowButtonMiddle: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNameConstants.leftArrow), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let rightArrowButtonMiddle: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNameConstants.rightArrow), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let leftArrowButtonBottom: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNameConstants.leftArrow), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let rightArrowButtonBottom: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNameConstants.rightArrow), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    // MARK: - Properties: Images

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DataManager.shared.loadProfileImage()
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    private let frameTop: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNameConstants.frame)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let frameMiddle: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNameConstants.frame)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let carImageView: UIImageView = {
        let imageView = UIImageView()
        let index = DataManager.shared.loadCarIndex()
        imageView.image = UIImage(named: Constants.carImageArray[index])
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let obstacleImageView: UIImageView = {
        let imageView = UIImageView()
        let index = DataManager.shared.loadObstacleIndex()
        imageView.image = UIImage(named: Constants.obstacleImageArray[index])
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let difficultyImageView: UIImageView = {
        let imageView = UIImageView()
        let index = DataManager.shared.loadDifficultyIndex()
        imageView.image = UIImage(named: Constants.difficultyImageArray[index - 1])
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Properties: Logic

    private var carIndex: Int = { DataManager.shared.loadCarIndex() }()
    private var obstacleIndex: Int = { DataManager.shared.loadObstacleIndex() }()
    private var difficultyIndex: Int = { DataManager.shared.loadDifficultyIndex() }()
    private var profileImageName: String = { DataManager.shared.loadProfileImageName() }()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        setupUI()
        addActionsToButtons()
    }
    
    deinit {
        print("Deinit")
    }
    
    // MARK: - UI Setup Functions
    
    private func setupUI() {
        
        view.backgroundColor = Constants.settingBgColor
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(textFieldShouldReturn))
        view.addGestureRecognizer(recognizer)
        
        view.addSubview(topContainer)
        view.addSubview(profileContainer)
        view.addSubview(nameContainer)
        view.addSubview(carContainer)
        view.addSubview(obstacleContainer)
        view.addSubview(difficultyContainer)
        
        topContainer.addSubview(backButton)
        
        profileContainer.addSubview(profileImageView)
        profileContainer.addSubview(uploadButton)
        
        nameContainer.addSubview(nameLabel)
        nameContainer.addSubview(nameTextField)

        carContainer.addSubview(carLabel)
        carContainer.addSubview(frameTop)
        carContainer.addSubview(carImageView)
        carContainer.addSubview(leftArrowButtonTop)
        carContainer.addSubview(rightArrowButtonTop)
        
        obstacleContainer.addSubview(obstacleLabel)
        obstacleLabel.addSubview(obstacleImageView)
        obstacleContainer.addSubview(leftArrowButtonMiddle)
        obstacleContainer.addSubview(frameMiddle)
        obstacleContainer.addSubview(rightArrowButtonMiddle)

        difficultyContainer.addSubview(difficultyLabel)
        difficultyContainer.addSubview(leftArrowButtonBottom)
        difficultyContainer.addSubview(difficultyImageView)
        difficultyContainer.addSubview(rightArrowButtonBottom)

        topContainer.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(CGFloat.settingsTopContainerHeight)
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(CGFloat.backButtonLeftOffset)
            make.bottom.equalToSuperview()
        }
        
        profileContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topContainer.snp.bottom)
            make.height.equalTo(CGFloat.settingsProfileContainerHeight)
        }

        profileImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(CGFloat.profileImageSize)
        }
        
        uploadButton.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(CGFloat.offset20)
            make.right.equalToSuperview().inset(CGFloat.offset20)
            make.height.equalTo(CGFloat.uploadButtonSize)
            make.centerY.equalTo(profileImageView.snp.centerY)
        }

        nameContainer.snp.makeConstraints { make in
            make.top.equalTo(profileContainer.snp.bottom)
            make.height.equalTo(topContainer.snp.height)
            make.left.right.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(CGFloat.offset15)
            make.top.right.equalToSuperview()
            make.height.equalTo(CGFloat.settingsLabelHeight)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(CGFloat.offset10)
            make.bottom.equalToSuperview().inset(CGFloat.offset10)
            make.left.right.equalToSuperview().inset(CGFloat.offset15)
        }
        
        carContainer.snp.makeConstraints { make in
            make.height.equalTo(difficultyContainer.snp.height)
            make.left.right.equalToSuperview()
            make.top.equalTo(nameContainer.snp.bottom)
        }
        
        carLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(CGFloat.offset15)
            make.top.equalToSuperview().inset(CGFloat.offset5)
            make.right.equalToSuperview()
            make.height.equalTo(nameLabel.snp.height)
        }
        
        frameTop.snp.makeConstraints { make in
            make.top.equalTo(carLabel.snp.bottom).offset(CGFloat.offset5)
            make.bottom.equalToSuperview().inset(CGFloat.offset5)
            make.centerX.equalToSuperview()
            make.width.equalTo(frameTop.snp.height)
        }
        
        carImageView.snp.makeConstraints { make in
            make.edges.equalTo(frameTop).inset(CGFloat.offset15)
        }
        
        leftArrowButtonTop.snp.makeConstraints { make in
            make.centerY.equalTo(frameTop.snp.centerY)
            make.left.equalToSuperview().inset(CGFloat.offset20)
            make.right.equalTo(frameTop.snp.left).offset(-CGFloat.offset20)
        }
        
        rightArrowButtonTop.snp.makeConstraints { make in
            make.centerY.equalTo(frameTop.snp.centerY)
            make.right.equalToSuperview().inset(CGFloat.offset20)
            make.left.equalTo(frameTop.snp.right).offset(CGFloat.offset20)
        }
        
        obstacleContainer.snp.makeConstraints { make in
            make.height.equalTo(difficultyContainer.snp.height)
            make.left.right.equalToSuperview()
            make.top.equalTo(carContainer.snp.bottom)
        }
        
        obstacleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(CGFloat.offset15)
            make.top.equalToSuperview().inset(CGFloat.offset5)
            make.right.equalToSuperview()
            make.height.equalTo(nameLabel.snp.height)
        }
        
        frameMiddle.snp.makeConstraints { make in
            make.top.equalTo(obstacleLabel.snp.bottom).offset(CGFloat.offset5)
            make.bottom.equalToSuperview().inset(CGFloat.offset5)
            make.centerX.equalToSuperview()
            make.width.equalTo(frameMiddle.snp.height)
        }
        
        obstacleImageView.snp.makeConstraints { make in
            make.edges.equalTo(frameMiddle).inset(CGFloat.offset20)
        }
        
        leftArrowButtonMiddle.snp.makeConstraints { make in
            make.centerY.equalTo(frameMiddle.snp.centerY)
            make.left.equalToSuperview().inset(CGFloat.offset20)
            make.right.equalTo(frameMiddle.snp.left).offset(-CGFloat.offset20)
        }
        
        rightArrowButtonMiddle.snp.makeConstraints { make in
            make.centerY.equalTo(frameMiddle.snp.centerY)
            make.right.equalToSuperview().inset(CGFloat.offset20)
            make.left.equalTo(frameMiddle.snp.right).offset(CGFloat.offset20)
        }
        
        difficultyContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(obstacleContainer.snp.bottom)
            make.bottom.equalToSuperview().inset(CGFloat.offset30)
        }
        
        difficultyLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(CGFloat.offset15)
            make.top.equalToSuperview().inset(CGFloat.offset5)
            make.right.equalToSuperview()
            make.height.equalTo(nameLabel.snp.height)
        }
        
        difficultyImageView.snp.makeConstraints { make in
            make.top.equalTo(difficultyLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(CGFloat.offset5)
            make.centerX.equalToSuperview()
            make.width.equalTo(difficultyImageView.snp.height)
        }
        
        leftArrowButtonBottom.snp.makeConstraints { make in
            make.centerY.equalTo(difficultyImageView.snp.centerY)
            make.left.equalToSuperview().inset(CGFloat.offset20)
            make.right.equalTo(difficultyImageView.snp.left).offset(-CGFloat.offset20)
        }
        
        rightArrowButtonBottom.snp.makeConstraints { make in
            make.centerY.equalTo(difficultyImageView.snp.centerY)
            make.right.equalToSuperview().inset(CGFloat.offset20)
            make.left.equalTo(difficultyImageView.snp.right).offset(CGFloat.offset20)
        }
    }
    
    private func addActionsToButtons() {
        
        let backButtonAction = UIAction { [weak self] _ in
            self?.backButtonPressed()
        }
        
        backButton.addAction(backButtonAction, for: .touchUpInside)
        
        let uploadAction = UIAction { [weak self] _ in
            self?.showImagePickerAlert()
        }
        
        uploadButton.addAction(uploadAction, for: .touchUpInside)
        
        let leftArrowTopAction = UIAction { [weak self] _ in
            self?.arrowButtonPressed(direction: .leftTop)
        }
        
        leftArrowButtonTop.addAction(leftArrowTopAction, for: .touchUpInside)
        
        let rightArrowTopAction = UIAction { [weak self] _ in
            self?.arrowButtonPressed(direction: .rightTop)
        }
        
        rightArrowButtonTop.addAction(rightArrowTopAction, for: .touchUpInside)
        
        let leftArrowMidAction = UIAction { [weak self] _ in
            self?.arrowButtonPressed(direction: .leftMiddle)
        }
        
        leftArrowButtonMiddle.addAction(leftArrowMidAction, for: .touchUpInside)
        
        let rightArrowMidAction = UIAction { [weak self] _ in
            self?.arrowButtonPressed(direction: .rightMiddle)
        }
        
        rightArrowButtonMiddle.addAction(rightArrowMidAction, for: .touchUpInside)
        
        let leftArrowBottomAction = UIAction { [weak self] _ in
            self?.arrowButtonPressed(direction: .leftBottom)
        }
        
        leftArrowButtonBottom.addAction(leftArrowBottomAction, for: .touchUpInside)
        
        let rightArrowBottomAction = UIAction { [weak self] _ in
            self?.arrowButtonPressed(direction: .rightBottom)
        }
        
        rightArrowButtonBottom.addAction(rightArrowBottomAction, for: .touchUpInside)
    }
    
    // MARK: - UIButton Functions
    
    private func backButtonPressed() {
        saveSettings()
        navigationController?.popViewController(animated: true)
    }
    
    private func arrowButtonPressed(direction: ArrowDirection) {
        switch direction {
            
        case .leftTop:
            if carIndex > 0 {
                carIndex -= 1
                UIView.transition(with: carImageView, duration: Constants.settingsAnimationDuration, options: .transitionFlipFromRight) {
                    self.carImageView.image = UIImage(named: Constants.carImageArray[self.carIndex])
                }
            }
        case .rightTop:
            if carIndex < Constants.carImageArray.count - 1 {
                carIndex += 1
                UIView.transition(with: carImageView, duration: Constants.settingsAnimationDuration, options: .transitionFlipFromRight) {
                    self.carImageView.image = UIImage(named: Constants.carImageArray[self.carIndex])
                }
            }
        case .leftMiddle:
            if obstacleIndex > 0 {
                obstacleIndex -= 1
                UIView.transition(with: obstacleImageView, duration: Constants.settingsAnimationDuration, options: .transitionFlipFromRight) {
                    self.obstacleImageView.image = UIImage(named: Constants.obstacleImageArray[self.obstacleIndex])
                }
            }
        case .rightMiddle:
            if obstacleIndex < Constants.obstacleImageArray.count - 1 {
                obstacleIndex += 1
                UIView.transition(with: obstacleImageView, duration: Constants.settingsAnimationDuration, options: .transitionFlipFromRight) {
                    self.obstacleImageView.image = UIImage(named: Constants.obstacleImageArray[self.obstacleIndex])
                }
            }
        case .leftBottom:
            if difficultyIndex > 1 {
                difficultyIndex -= 1
                difficultyImageView.image = UIImage(named: Constants.difficultyImageArray[difficultyIndex - 1])
                print(difficultyIndex)
            }
        case .rightBottom:
            if difficultyIndex < Constants.difficultyImageArray.count {
                difficultyIndex += 1
                    difficultyImageView.image = UIImage(named: Constants.difficultyImageArray[difficultyIndex - 1])
                print(difficultyIndex)
            }
        }
    }
    
    // MARK: - Flow Functions
    
    private func showImagePickerAlert() {
        
        let alert = UIAlertController(title: Constants.imageSource, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: Constants.camera, style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.showImagePicker(source: .camera)
            }
        }
        alert.addAction(cameraAction)
        
        let photoLibraryAction = UIAlertAction(title: Constants.photoLibrary, style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.showImagePicker(source: .photoLibrary)
            }
        }
        alert.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: Constants.cancel, style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func showImagePicker(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true)
    }
    
    private func saveSettings() {
        
        var nameToSave: String = Constants.guest
        
        if let name = nameTextField.text {
            nameToSave = name
        }
        
        let settings = Settings(name: nameToSave, profileImageName: profileImageName, carIndex: carIndex, obstacleIndex: obstacleIndex, difficultyIndex: difficultyIndex)
        
        DataManager.shared.saveData(data: settings, for: .settings)
    }
}

    // MARK: - UIImagePicker Delegate Methods

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            tryToSaveImage(image)
        } else if let image = info[.originalImage] as? UIImage {
            tryToSaveImage(image)
        }
        
        picker.dismiss(animated: true)
    }
    
    private func tryToSaveImage(_ image: UIImage) {
        
        if let imageName = ImageManager.shared.saveImage(image) {
            print("image saved to FileManager")
            profileImageName = imageName
            profileImageView.image = image
        }
    }
}

    // MARK: - UITextField Delegate Methods

extension SettingsViewController {
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
