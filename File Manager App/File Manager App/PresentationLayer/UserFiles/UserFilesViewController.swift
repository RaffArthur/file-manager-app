//
//  UserFilesViewController.swift
//  File Manager App
//
//  Created by Arthur Raff on 29.04.2022.
//

import UIKit

import SnapKit

final class UserFilesViewController: UIViewController {
    private lazy var imagePickerController: UIImagePickerController = {
        let ipc = UIImagePickerController()
        ipc.delegate = self
        
        return ipc
    }()

    private lazy var addFileButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "doc.badge.plus")
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(UserFilesTableViewCell.self,
                    forCellReuseIdentifier: String(describing: UserFilesTableViewCell.self))
        tv.delegate = self
        tv.dataSource = self
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
}

private extension UserFilesViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupContent() {
        view.backgroundColor = .white
        
        tableView.backgroundColor = .white
        
        title = "Файлы"
        
        navigationItem.rightBarButtonItem = addFileButton
    }
}

extension UserFilesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
}

extension UserFilesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: UserFilesTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier ,
                                                 for: indexPath) as? UserFilesTableViewCell

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                             title: "Удалить") { action, view, success in
            tableView.deleteRows(at: [indexPath], with: .automatic)
                        
            success(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension UserFilesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
    }
}
