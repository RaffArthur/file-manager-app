//
//  ChangePasswordView.swift
//  File Manager App
//
//  Created by Arthur Raff on 09.05.2022.
//

import Foundation
import UIKit

final class ChangePasswordView: UIView {
    var userOldPassword: String? { userOldPasswordField.text }
    var userNewPassword: String? { userNewPasswordField.text }
    var userRepeatNewPassword: String? { userRepeatNewPasswordField.text }
    
    weak var delegate: ChangePasswordViewDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.automaticallyAdjustsScrollIndicatorInsets = true

        return sv
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()

        return view
    }()
    
    private lazy var changePasswordTitle: UILabel = {
        let label = UILabel()
        label.text = "Смена пароля"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var userOldPasswordField: UITextField = {
        let stringAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.4)]
        let attributedString = NSAttributedString(string: "Введите старый пароль",
                                                  attributes: stringAttributes)
        
        let tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.textContentType = .password
        tf.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        tf.attributedPlaceholder = attributedString
        tf.textColor = .white
        tf.textAlignment = .left
        tf.layer.backgroundColor = UIColor.systemIndigo.cgColor
        tf.layer.shadowOffset = CGSize(width: 0, height: 1)
        tf.layer.shadowOpacity = 1
        tf.layer.shadowRadius = 0
        tf.layer.shadowColor = UIColor.white.cgColor
        tf.delegate = self
        
        return tf
    }()
        
    private lazy var userNewPasswordField: UITextField = {
        let stringAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.4)]
        let attributedString = NSAttributedString(string: "Введите новый пароль",
                                                  attributes: stringAttributes)
        
        let tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.textContentType = .newPassword
        tf.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        tf.attributedPlaceholder = attributedString
        tf.textColor = .white
        tf.textAlignment = .left
        tf.layer.backgroundColor = UIColor.systemIndigo.cgColor
        tf.layer.shadowOffset = CGSize(width: 0, height: 1)
        tf.layer.shadowOpacity = 1
        tf.layer.shadowRadius = 0
        tf.layer.shadowColor = UIColor.white.cgColor
        tf.delegate = self
        
        return tf
    }()
    
    private lazy var userRepeatNewPasswordField: UITextField = {
        let stringAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.4)]
        let attributedString = NSAttributedString(string: "Повторите новый пароль",
                                                  attributes: stringAttributes)
        
        let tf = UITextField()
        tf.contentVerticalAlignment = .center
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.textContentType = .newPassword
        tf.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        tf.attributedPlaceholder = attributedString
        tf.textColor = .white
        tf.textAlignment = .left
        tf.layer.backgroundColor = UIColor.systemIndigo.cgColor
        tf.layer.shadowOffset = CGSize(width: 0, height: 1)
        tf.layer.shadowOpacity = 1
        tf.layer.shadowRadius = 0
        tf.layer.shadowColor = UIColor.white.cgColor
        tf.delegate = self
        
        return tf
    }()
    
    private lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подтвердить", for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(1), for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.4), for: .highlighted)
        button.backgroundColor = .black.withAlphaComponent(0.2)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ChangePasswordView {
    @objc func registrationButtonWasTapped() {
        delegate?.didTapChangePasswordButton()
    }
    
    func setupActions() {
        changePasswordButton.addTarget(self, action: #selector (registrationButtonWasTapped), for: .touchUpInside)
    }
}

private extension ChangePasswordView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.add(subviews: [changePasswordTitle,
                                   userOldPasswordField,
                                   userNewPasswordField,
                                   userRepeatNewPasswordField,
                                   changePasswordButton])
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.edges.equalTo(scrollView)
        }
        
        changePasswordTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(80)
            make.centerX.equalToSuperview()
        }
        
        userOldPasswordField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(changePasswordTitle.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userNewPasswordField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(userOldPasswordField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userRepeatNewPasswordField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(userNewPasswordField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        changePasswordButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(userRepeatNewPasswordField.snp.bottom).offset(24)
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
    }
    
    func setupContent() {
        backgroundColor = .systemIndigo
        
        userOldPasswordField.enablePasswordVisibiltyToggle()
        userNewPasswordField.enablePasswordVisibiltyToggle()
        userRepeatNewPasswordField.enablePasswordVisibiltyToggle()
    }
}

extension ChangePasswordView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
