//
//  GoalPickerTableViewCell.swift
//  MissionPR
//
//  Created by Lane Faison on 1/2/20.
//  Copyright © 2020 Lane Faison. All rights reserved.
//

import UIKit

class GoalPickerTableViewCell: UITableViewCell, ConfigurableCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.placeholderText, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .dividerColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var buttonTapAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(divider)
        divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: divider.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2).isActive = true
        
        contentView.addSubview(button)
        button.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: divider.topAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: GoalPickerCellViewModel) {
        titleLabel.text = viewModel.title
        button.setTitle(viewModel.placeholder, for: .normal)
        divider.isHidden = viewModel.shouldHideDivider ?? false
        buttonTapAction = viewModel.buttonAction
    }
    
    @objc private func buttonTapped() {
        buttonTapAction?()
    }
}
