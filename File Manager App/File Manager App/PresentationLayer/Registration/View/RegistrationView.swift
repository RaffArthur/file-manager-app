//
//  RegistrationView.swift
//  File Manager App
//
//  Created by Arthur Raff on 29.04.2022.
//

import UIKit

final class RegistrationView: UIView {
    var userPassword: String? { userPasswordField.text }
    var userRepeatPassword: String? { userRepeatPasswordField.text }
    
    weak var delegate: RegistrationViewDelegate?
    
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
    
    private lazy var registrationTitle: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        
        return label
    }()
        
    private lazy var userPasswordField: UITextField = {
        let stringAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.4)]
        let attributedString = NSAttributedString(string: "Введите пароль",
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
    
    private lazy var userRepeatPasswordField: UITextField = {
        let stringAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.4)]
        let attributedString = NSAttributedString(string: "Повторите пароль",
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
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(1), for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.4), for: .highlighted)
        button.backgroundColor = .black.withAlphaComponent(0.2)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private lazy var haveAnAccountButton: UIButton = {
        let titleAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.4),
                               NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium)]
        let buttonAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium)]
        let titleAttributedString = NSMutableAttributedString(string: "Уже есть аккаунт? ", attributes: titleAttributes)
        let buttonAttributedString = NSAttributedString(string: "Войти", attributes: buttonAttributes)
        titleAttributedString.append(buttonAttributedString)
        
        let button = UIButton()
        button.setAttributedTitle(titleAttributedString, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupActions()
                
        userPasswordField.enablePasswordVisibiltyToggle()
        userRepeatPasswordField.enablePasswordVisibiltyToggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension RegistrationView {
    @objc func registrationButtonWasTapped() {
        delegate?.didTapRegistrationButton()
    }
    
    @objc func haveAnAccountButtonWasTapped() {
        delegate?.didTapHaveAnAccountButton()
    }
    
    func setupActions() {
        registrationButton.addTarget(self, action: #selector (registrationButtonWasTapped), for: .touchUpInside)
        haveAnAccountButton.addTarget(self, action: #selector (haveAnAccountButtonWasTapped), for: .touchUpInside)
    }
}

private extension RegistrationView {
    func setupView() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.add(subviews: [registrationTitle,
                                   userPasswordField,
                                   userRepeatPasswordField,
                                   registrationButton,
                                   haveAnAccountButton])
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.edges.equalTo(scrollView)
        }
        
        registrationTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(80)
            make.centerX.equalToSuperview()
        }
        
        userPasswordField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(registrationTitle.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        userRepeatPasswordField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(userPasswordField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(userRepeatPasswordField.snp.bottom).offset(24)
            make.centerX.equalTo(contentView)
        }
        
        haveAnAccountButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(registrationButton).offset(60)
            make.bottom.equalTo(contentView)
        }
    }
    
    func setupContent() {
        backgroundColor = .systemIndigo
    }
}

extension RegistrationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
