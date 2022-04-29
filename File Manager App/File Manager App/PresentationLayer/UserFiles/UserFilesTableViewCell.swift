//
//  UserFilesTableViewCell.swift
//  File Manager App
//
//  Created by Arthur Raff on 29.04.2022.
//

import UIKit

final class UserFilesTableViewCell: UITableViewCell {
    private lazy var filePreview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        
        return iv
    }()
    
    private lazy var fileTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var fileCreationDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGray

        return label
    }()
    
    private lazy var fileType: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGray

        return label
    }()
    
    private lazy var fileSize: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGray

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UserFilesTableViewCell {
    func setupCell() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        contentView.addSubview(filePreview)
        contentView.addSubview(fileTitle)
        contentView.addSubview(fileCreationDate)
        contentView.addSubview(fileType)
        contentView.addSubview(fileSize)
        
        filePreview.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        fileTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(filePreview.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        fileType.snp.makeConstraints { make in
            make.top.equalTo(fileTitle.snp.bottom).offset(8)
            make.leading.equalTo(filePreview.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-8)
        }
                
        fileSize.snp.makeConstraints { make in
            make.top.equalTo(fileType.snp.bottom).offset(8)
            make.leading.equalTo(filePreview.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        fileCreationDate.snp.makeConstraints { make in
            make.top.equalTo(fileSize.snp.bottom).offset(8)
            make.leading.equalTo(filePreview.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    func setupContent() {
        backgroundColor = .white
    }
}
