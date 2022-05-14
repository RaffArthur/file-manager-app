//
//  UserSettingsStaticTableViewCell.swift
//  File Manager App
//
//  Created by Arthur Raff on 03.05.2022.
//

import Foundation
import UIKit

final class UserSettingsStaticTableViewCell: UITableViewCell {
    private lazy var settingIcon: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    private lazy var settingTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    private lazy var settingChevron: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        
        return iv
    }()
        
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserSettingsStaticTableViewCell {
    func configure(option: SettingsStaticOption) {
        guard let optionIcon = option.icon
        else {
            return
        }
        
        settingIcon.image = UIImage(systemName: optionIcon)
        settingIcon.tintColor = option.iconTintColor
        settingTitle.text = option.title
    }
}

private extension UserSettingsStaticTableViewCell {
    func setupCell() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        backgroundColor = .white
    }
    
    func setupLayout() {
        contentView.add(subviews: [settingIcon,
                                   settingTitle,
                                   settingChevron])
        
        settingIcon.snp.makeConstraints { make in
            make.size.equalTo(30).priority(999)
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        settingTitle.snp.makeConstraints { make in
            make.leading.equalTo(settingIcon.snp.trailing).offset(8)
            make.centerY.equalTo(settingIcon)
        }
        
        settingChevron.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalTo(settingTitle)
        }
    }
}
