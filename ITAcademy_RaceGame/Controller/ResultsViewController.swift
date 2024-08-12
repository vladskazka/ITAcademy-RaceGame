//
//  ResultsViewController.swift
//  ITAcademy_RaceGame
//
//  Created by Влад Муравьев on 01.05.2024.
//

import UIKit

class ResultsViewController: UIViewController {
        
    private let loadSettings: Any? = {
        DataManager.shared.loadSettings()
        return nil
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
    
    // MARK: - Properties: Labels
    
    private let leaderboardLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.leaderboardLabel
        label.textColor = .white
        label.textAlignment = .right
        label.font = .monospacedSystemFont(ofSize: CGFloat.titleFontSize, weight: .bold)
        return label
    }()
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.positionLabel
        label.textColor = .white
        label.textAlignment = .center
        label.font = .monospacedSystemFont(ofSize: CGFloat.tableTitleFontSize, weight: .heavy)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.nameLabel
        label.textColor = .white
        label.textAlignment = .center
        label.font = .monospacedSystemFont(ofSize: CGFloat.tableTitleFontSize, weight: .heavy)
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.scoreLabel
        label.textColor = .white
        label.textAlignment = .center
        label.font = .monospacedSystemFont(ofSize: CGFloat.tableTitleFontSize, weight: .heavy)
        return label
    }()
    
    // MARK: - Properties: TableView

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
//        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.id)
        return tableView
    }()
    
    // MARK: - Properties: Logic
    
    private let resultArray: [Result] = {
        let savedResults = DataManager.shared.loadResults()
        if let array = savedResults?.sorted(by: { $0.score > $1.score}) {
            return array
        } else {
            return []
        }
    }()
    
    // MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addActionsToButtons()
    }
    
    // MARK: - Flow Functions
    
    private func setupUI() {
        
        view.backgroundColor = .brown
        
        view.addSubview(backButton)
        view.addSubview(leaderboardLabel)
        
        view.addSubview(tableView)
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.backButtonLeftOffset)
            make.top.equalToSuperview().offset(CGFloat.backButtonTopOffset)
        }
        
        leaderboardLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(CGFloat.offset30)
            make.left.right.equalToSuperview().inset(CGFloat.offset30)
            
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(leaderboardLabel.snp.bottom).offset(CGFloat.offset30)
            make.left.right.equalToSuperview().inset(CGFloat.offset20)
            make.bottom.equalToSuperview().inset(CGFloat.offset100)
        }
        
    }
    
    private func addActionsToButtons() {
        let backButtonAction = UIAction { _ in
            self.backButtonPressed()
        }
        
        backButton.addAction(backButtonAction, for: .touchUpInside)
    }
    
    private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegateFunctions

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.id, for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }
        
        if indexPath.row > 0 {
            cell.configureCell(index: indexPath.row, result: resultArray[indexPath.row - 1])
        } else {
            cell.configureDefaultCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat.cellHeight
    }
}
