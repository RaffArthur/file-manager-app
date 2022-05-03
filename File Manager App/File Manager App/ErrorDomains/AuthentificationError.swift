//
//  AuthentificationError.swift
//  File Manager App
//
//  Created by Arthur Raff on 01.05.2022.
//

import Foundation

enum AuthentificationError: Error {
    case wrongPassword
    case weakPassword
    case userAlreadyExist
    case mismatchPasswords
    case emptyFields
    case unknownError
}

extension AuthentificationError {
    var title: String {
        switch self {
        case .wrongPassword:
            return "Неверный пароль"
        case .weakPassword:
            return "Ненадежный пароль"
        case .userAlreadyExist:
            return "Пользователь существует"
        case .mismatchPasswords:
            return "Пароли не совпадают"
        case .emptyFields:
            return "Поля пустые"
        case .unknownError:
            return "Неизвестная ошибка"
        }
    }
    
    var message: String {
        switch self {
        case .wrongPassword:
            return "Неверный пароль, создайте новый пароль или повторите попытку входа"
        case .weakPassword:
            return "Введите пароль состоящий минимум из 4 символов и повторите попытку"
        case .userAlreadyExist:
            return "Пользователь уже существует, выполните вход или повторите попытку"
        case .mismatchPasswords:
            return "Введенные пароли не совпадают, повторите попытку"
        case .emptyFields:
            return "Заполните поля данными и повторите попытку"
        case .unknownError:
            return "Возникла неизвестная ошибка, повторите попытку позднее"
        }
    }
}
