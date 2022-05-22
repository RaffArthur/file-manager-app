//
//  TabCoordinator.swift
//  File Manager App
//
//  Created by Arthur Raff on 08.05.2022.
//

import Foundation
import UIKit

final class TabCoordinator: NSObject, TabCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var tabBarController: UITabBarController
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .tab }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        let pages = TabBarPage.allCases.sorted { $0.pageOrderNumber() < $1.pageOrderNumber() }
        let controllers: [UINavigationController] = pages.map { getTabController($0) }
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.files.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = true
        
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: true)
        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(),
                                                image: page.pageIconValue(),
                                                tag: page.pageOrderNumber())
        
        switch page {
        case .files:
            showUserFilesFlow(navController: navController)
        case .settings:
            showUserSettings(navController: navController)
        }
        
        return navController
    }

    func currentPage() -> TabBarPage? {
        TabBarPage(index: tabBarController.selectedIndex)
    }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func selectedIndex(_ index: Int) {
        guard let page = TabBarPage(index: index) else { return }

        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func showUserFilesFlow(navController: UINavigationController) {
        let userFilesCoordinator = UserFilesCoordinator(navController)
        
        userFilesCoordinator.start()
        
        childCoordinators.append(userFilesCoordinator)
    }

    func showUserSettings(navController: UINavigationController) {
        let userSettingsCoordinator = UserSettingsCoordinator(navController)
        
        userSettingsCoordinator.start()
        
        childCoordinators.append(userSettingsCoordinator)
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        
    }
}
