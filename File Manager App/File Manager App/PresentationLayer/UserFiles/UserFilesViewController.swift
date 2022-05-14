//
//  UserFilesViewController.swift
//  File Manager App
//
//  Created by Arthur Raff on 29.04.2022.
//

import UIKit

import SnapKit

final class UserFilesViewController: UIViewController {
    private var userFiles: [UserFile] = []
    
    weak var fileManager: AppFileManager?
    
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
        tv.rowHeight = UITableView.automaticDimension
        tv.register(UserFilesTableViewCell.self,
                    forCellReuseIdentifier: String(describing: UserFilesTableViewCell.self))
        tv.delegate = self
        tv.dataSource = self
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFullFilesData()
        
        setupScreen()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setFileSortingBySwitcherState()
    }
}

private extension UserFilesViewController {
    func getFullFilesData() {
        fileManager?.getFilesWithAttributes(atDirectory: .documentDirectory) { fullFilesData in
            let convertedFullFilesData = fullFilesData.compactMap {
                UserFile(url:  $0.file.absoluteString,
                         name: $0.file.lastPathComponent,
                         size: convert(attribute: .size, in: $0.attributes),
                         format: $0.file.lastPathComponent.components(separatedBy: ".").last,
                         creationDate: convert(attribute: .creationDate, in: $0.attributes))
            }
            
            userFiles = convertedFullFilesData
            
            setFileSortingBySwitcherState()
            
            tableView.reloadData()
        }
    }
        
    func convert(attribute: FileAttributeKey, in attributes: [FileAttributeKey: Any]) -> String {
        for _ in attributes {
            if attribute == .size {
                guard let size = attributes[.size],
                      let sizeDouble = size as? Int64
                else {
                    return String()
                }
                
                let formattedSize = ByteCountFormatter.string(fromByteCount: sizeDouble, countStyle: .file)
                
                return "\(formattedSize)"
            }
            
            if attribute == .creationDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                dateFormatter.timeZone = TimeZone(identifier: "RU")
                dateFormatter.locale = Locale(identifier: "RU")
                
                guard let creationDate = attributes[.creationDate],
                      let formattedCreationDate = dateFormatter.string(for: creationDate)
                else {
                    return String()
                }
                
                return formattedCreationDate
            }
        }
        
        return "отсутствует"
    }
}

private extension UserFilesViewController {
    func setFileSortingBySwitcherState() {
        let switcherIsOn = UserDefaults.standard.bool(forKey: SettingsKeys.sortFiles.key)
        
        if switcherIsOn == true {
            userFiles.sort {
                guard let lhs = $0.name,
                      let rhs = $1.name
                else {
                    return Bool()
                }
                
                return lhs > rhs
            }
        } else {
            userFiles.sort {
                guard let lhs = $0.name,
                      let rhs = $1.name
                else {
                    return Bool()
                }
                
                return lhs < rhs
            }
        }
        
        tableView.reloadData()
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

private extension UserFilesViewController {
    func setupActions() {
        addFileButton.action = #selector(addFileToDocuments)
        addFileButton.target = self
    }
    
    @objc func addFileToDocuments() {
        imagePickerController.modalPresentationStyle = .automatic
        
        present(imagePickerController, animated: true)
    }
}

extension UserFilesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UserFilesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return userFiles.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: UserFilesTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier ,
                                                 for: indexPath) as? UserFilesTableViewCell
        
        cell?.configure(file: userFiles[indexPath.row])

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                             title: "Удалить") { action, view, success in
            guard let name = self.userFiles[indexPath.row].name else { return }
            
            self.fileManager?.removeFileOrDirectory(withName: name,
                                                    atDirectory: .documentDirectory)
            
            self.userFiles.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
                        
            success(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension UserFilesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = (info[.originalImage] as? UIImage)?.jpegData(compressionQuality: 0.2),
              let name = (info[.imageURL] as? URL)?.lastPathComponent
        else {
            return
        }
        
        fileManager?.create(file: image,
                            withName: name,
                            atDirectory: .documentDirectory)
        
        picker.dismiss(animated: true)
        
        getFullFilesData()
    }
}
