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
    case wrongOldPassword
    case passwordAlreadyInUse
    case userAlreadyExist
    case userNotFound
    case mismatchPasswords
    case emptyFields
    case unknownError
}

extension AuthentificationError {
    var title: String {
        switch self {
        case .wrongPassword,
             .wrongOldPassword:
            return "Неверный пароль"
        case .weakPassword:
            return "Ненадежный пароль"
        case .passwordAlreadyInUse:
            return "Пароль уже используется"
        case .userAlreadyExist:
            return "Пользователь существует"
        case .userNotFound:
            return "Пользователь не найден"
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
        case .wrongOldPassword:
            return "Старый пароль введен неверно, повторите попытку ввода"
        case .passwordAlreadyInUse:
            return "Этот пароль уже используется этим аккаунтом, введите новый пароль и повторите поптыку"
        case .userAlreadyExist:
            return "Пользователь уже существует, выполните вход или повторите попытку"
        case .userNotFound:
            return "Такого пользователя не существует, зарегистрируйтесь, чтобы выполнить вход"
        case .mismatchPasswords:
            return "Введенные пароли не совпадают, повторите попытку"
        case .emptyFields:
            return "Заполните поля данными и повторите попытку"
        case .unknownError:
            return "Возникла неизвестная ошибка, повторите попытку позднее"
        }
    }
}
