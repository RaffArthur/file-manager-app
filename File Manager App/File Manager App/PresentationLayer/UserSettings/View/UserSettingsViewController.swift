//
//  UserSettingsViewController.swift
//  File Manager App
//
//  Created by Arthur Raff on 03.05.2022.
//

import Foundation
import UIKit

final class UserSettingsViewController: UIViewController {
    weak var delegate: UserSettingsViewControllerDelegate?
    
    private var sections = UserSettingsConfigurator.configureSections()
    
    private let userDefaults = UserDefaults.standard
        
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.rowHeight = UITableView.automaticDimension
        tv.register(UserSettingsStaticTableViewCell.self,
                    forCellReuseIdentifier: String(describing: UserSettingsStaticTableViewCell.self))
        tv.register(UserSettingsSwitcherTableViewCell.self,
                    forCellReuseIdentifier: String(describing: UserSettingsSwitcherTableViewCell.self))
        tv.delegate = self
        tv.dataSource = self
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
}

private extension UserSettingsViewController {
    func setupScreen() {
        setupContent()
        setupLayout()
    }
    
    func setupContent() {
        title = "Настройки"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension UserSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let option = sections[indexPath.section].options[indexPath.row]
        
        switch option {
        case .switchCell:
            return
        case .staticCell(let option):
            if option.type == .changePassword {
                delegate?.didChangePasswordCellTapped()
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UserSettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = sections[indexPath.section].options[indexPath.row]
        
        switch option {
        case .staticCell(let option):
            let identifier = String(describing: UserSettingsStaticTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath) as? UserSettingsStaticTableViewCell
            
            cell?.configure(option: option)
            
            return cell ?? UITableViewCell()
        case .switchCell(let option):
            let identifier = String(describing: UserSettingsSwitcherTableViewCell.self)
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                     for: indexPath) as? UserSettingsSwitcherTableViewCell
            
            cell?.selectionStyle = .none
            
            cell?.configure(option: option)
            
            guard let optionType = option.type else { return UITableViewCell() }
            
            cell?.didTapSwitcher = {
                if optionType == .sortFiles {
                    self.userDefaults.set(cell?.switcherIsOn, forKey: SettingsKeys.sortFiles.key)
                }
            }
            
            cell?.switcherIsOn = userDefaults.bool(forKey: SettingsKeys.sortFiles.key)
            
            return cell ?? UITableViewCell()
        }
    }
}
