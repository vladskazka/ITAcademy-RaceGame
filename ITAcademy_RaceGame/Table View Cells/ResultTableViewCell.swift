//
//  ResultTableViewCell.swift
//  ITAcademy_RaceGame
//
//  Created by Влад Муравьев on 13.06.2024.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    // MARK: - Properties: ID

    static var id: String { "\(Self.self)" }
    
    // MARK: - Properties: Containers
    
    private let rowContainer = UIView()
    
    private let rowNameSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.1)
        return view
    }()
    
    private let rowScoreSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.1)
        return view
    }()
    
    // MARK: - Properties: Labels
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .brown
        
        contentView.addSubview(rowContainer)
        contentView.addSubview(rowNameSeparator)
        contentView.addSubview(rowScoreSeparator)
        
        rowContainer.addSubview(positionLabel)
        rowNameSeparator.addSubview(nameLabel)
        rowContainer.addSubview(dateLabel)
        rowScoreSeparator.addSubview(scoreLabel)
        
        rowContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        rowNameSeparator.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(50)
            make.right.equalTo(contentView.snp.left).offset(160)
        }
        
        rowScoreSeparator.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(contentView.snp.right).inset(80)
        }
        
        positionLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(rowNameSeparator.snp.left)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(rowNameSeparator.snp.right)
            make.right.equalTo(rowScoreSeparator.snp.left)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Flow Functions
    
    override func prepareForReuse() {
        positionLabel.text = nil
        nameLabel.text = nil
        dateLabel.text = nil
        scoreLabel.text = nil
    }
    
    func configureCell(index: Int, result: Result) {
        
        let alpha: Double = index % 2 == 0 ? 0.2 : 0.1
        
        rowContainer.backgroundColor = .white.withAlphaComponent(alpha)
        positionLabel.text = "\(index)"
        positionLabel.font = .monospacedSystemFont(ofSize: 15, weight: .heavy)
        nameLabel.text = result.name
        nameLabel.font = .monospacedSystemFont(ofSize: 15, weight: .heavy)
        dateLabel.text = result.date
        dateLabel.font = .monospacedSystemFont(ofSize: 15, weight: .heavy)
        scoreLabel.text = "\(result.score)"
        scoreLabel.font = .monospacedSystemFont(ofSize: 15, weight: .heavy)
    }
    
    func configureDefaultCell() {
        
        rowContainer.backgroundColor = .black.withAlphaComponent(0.2)
        
        positionLabel.text = Constants.positionLabel
        positionLabel.font = .monospacedSystemFont(ofSize: CGFloat.tableTitleFontSize, weight: .heavy)
        nameLabel.text = Constants.nameLabel
        nameLabel.font = .monospacedSystemFont(ofSize: CGFloat.tableTitleFontSize, weight: .heavy)
        dateLabel.text = Constants.dateLabel
        dateLabel.font = .monospacedSystemFont(ofSize: CGFloat.tableTitleFontSize, weight: .heavy)
        scoreLabel.text = Constants.scoreLabel
        scoreLabel.font = .monospacedSystemFont(ofSize: CGFloat.tableTitleFontSize, weight: .heavy)
    }
    
}
