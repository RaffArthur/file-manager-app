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
    
    private lazy var fileFormat: UILabel = {
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
extension UserFilesTableViewCell {
    func configure(file: UserFile) {
        guard let userFileUrl = file.url,
              let userFullUrl = URL(string: userFileUrl),
              let userFileData = try? Data(contentsOf: userFullUrl),
              let userFileName = file.name,
              let userFileCreationDate = file.creationDate,
              let userFileSize = file.size,
              let userFileFormat = file.format
        else {
            return
        }
        
        let imageSize = CGSize(width: 120, height: 120)
        let originalImage = UIImage(data: userFileData)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        let imgRect = CGRect(origin: CGPoint.zero, size: imageSize)
        originalImage?.draw(in: imgRect)
        let imageCopy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        filePreview.image = imageCopy
        fileTitle.text = "Имя: \(userFileName)"
        fileCreationDate.text = "Дата создания: \(userFileCreationDate)"
        fileSize.text = "Размер: \(userFileSize)"
        fileFormat.text = "Тип файла: \(userFileFormat)"
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
        contentView.addSubview(fileFormat)
        contentView.addSubview(fileSize)
        
        filePreview.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.top.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8).priority(999)
        }
        
        fileTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(filePreview.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        fileFormat.snp.makeConstraints { make in
            make.top.equalTo(fileTitle.snp.bottom).offset(8)
            make.leading.equalTo(filePreview.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-8)
        }
                
        fileSize.snp.makeConstraints { make in
            make.top.equalTo(fileFormat.snp.bottom).offset(8)
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
