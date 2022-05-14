//
//  UserFilesCoordinator.swift
//  File Manager App
//
//  Created by Arthur Raff on 08.05.2022.
//

import Foundation
import UIKit

final class UserFilesCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .files }
    
    private let fileManager = AppFileManagerImpl()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let userFilesVC = UserFilesViewController()
        userFilesVC.fileManager = fileManager
        
        navigationController.pushViewController(userFilesVC, animated: true)
    }
}
