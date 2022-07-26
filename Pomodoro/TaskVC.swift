//
//  TaskVC.swift
//  Pomodoro
//
//  Created by Osaretin Uyigue on 7/26/22.
//

import UIKit
fileprivate let cellReUseIdentifier = "TaskVC-cellReUseIdentifier"

fileprivate enum TaskSection: Int, CustomStringConvertible {
    case  pendingTasks, completedTasks
    var description: String {
        switch self {
        case .pendingTasks: return "Pending Tasks"
        case .completedTasks: return "Completed Tasks"
        }
    }
}

class TaskVC: UIViewController {
    
    //MARK: - View's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavItems()
        setUpViews()
    }
    
    //MARK: - Properties
    
    fileprivate let taskSections: [TaskSection] = [.pendingTasks, .completedTasks]
    
    fileprivate var tasks = [
        "Build Pomodoro app's task screen's tableView",
        "Add swipe actions to cells",
        "Add dummy data to task screen",
        "Configure cell's UI",
        "Build and Design Add New Task View",
        "Add gif to Drag to Reorder Collectionview cells Tutorial",
        "Write and Deploy building Youtube Video Player tutorial to blog site",
        "Email Suggestion article"
    ]
    
    
    fileprivate var completedTasks = [
        "Completed task one",
        "Take big break now"

    ]
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    
    fileprivate let addNewTaskButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20,
                                                 weight: .black,
                                                 scale: .medium)
        
        let image = UIImage(systemName: "plus.circle.fill",
                            withConfiguration:
                                config)?.withRenderingMode(.alwaysTemplate)
        
        button.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.setTitle("ADD NEW", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageEdgeInsets = .init(top: 0, left: -15, bottom: 0, right: 0)
        return button
    }()
    
    
    //MARK: - Methods
    fileprivate func setUpNavItems() {
        navigationItem.title = "Tasks"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.appMainColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.appMainColor]

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        
////        et appearance = UINavigationBarAppearance()
//        appearance.shadowColor = .clear
////        Assign this appearance to the UINavigationBar:
//
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    
    
    fileprivate func setUpViews() {
        setUpTableView()
        
        view.addSubview(addNewTaskButton)
        NSLayoutConstraint.activate([
            addNewTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            addNewTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            addNewTaskButton.widthAnchor.constraint(equalToConstant: 180),
            addNewTaskButton.heightAnchor.constraint(equalToConstant: 60),
            
            
        
        ])
    }
    
    
    fileprivate func setUpTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.cellReuseIdentifier)
    }
}



//MARK: - TableView Protocols
extension TaskVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.cellReuseIdentifier, for: indexPath) as! TaskCell
        
        switch taskSections[indexPath.section] {
        case .pendingTasks:
            cell.taskTitleLabel.text = tasks[indexPath.row]
            cell.taskTitleLabel.textColor = UIColor.black.withAlphaComponent(0.8)
        case .completedTasks:
            cell.taskTitleLabel.text = completedTasks[indexPath.row]
            cell.taskTitleLabel.textColor = UIColor.lightGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch taskSections[section] {
            
        case .pendingTasks:
            return tasks.count
        case .completedTasks:
            return completedTasks.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return taskSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch taskSections[section] {
        case .pendingTasks:
            return TaskSection.pendingTasks.description
        case .completedTasks:
            return TaskSection.completedTasks.description
        }
    }
    
    
    
    //MARK: - Swipe Actions
    private func handleMarkTaskAsComplete(at indexPath: IndexPath) {
        switch taskSections[indexPath.section] {
        case .pendingTasks:
            //remove swiped task from pendingTasks
            let completed_Task = tasks.remove(at: indexPath.row)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.tableView.deleteRows(at: [indexPath], with: .right)
            }
            
            //add the task to completedTasks section
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                self.completedTasks.insert(completed_Task, at: 0)
//                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                self.completedTasks.insert(completed_Task, at: 0)
                self.tableView.reloadData()
                
            }
          

        case .completedTasks:
            //remove swiped task from completedTasks
            let pending_Task = completedTasks.remove(at: indexPath.row)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.tableView.deleteRows(at: [indexPath], with: .left)
            }
            
            //add the task to pendingTasks section
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.tasks.insert(pending_Task, at: 0)
                self.tableView.reloadData()
            }
           
        }
        
    }
    
    
    private func handleDeleteCell(indexPath: IndexPath) {
        let alertVC = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete this task?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _  in
            self?.deleteTask(at: indexPath)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _  in
            self?.tableView.reloadRows(at: [indexPath], with: .right)
        }
        
        alertVC.addAction(deleteAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true)
    }
    
    
    
    private func deleteTask(at indexPath: IndexPath) {
        switch taskSections[indexPath.section] {
        case .pendingTasks:
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            
        case .completedTasks:
            completedTasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    
    
    
    private func createSwipeAction(imageName: String, targetAction: Void) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
            targetAction
            completionHandler(true)
        }
        action.backgroundColor = .white
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .black, scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration:
                                config)?.colored(in: .appMainColor)
        action.image = image
        
        return action
    }
    
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var imageName: String
        
        switch taskSections[indexPath.section] {
        case .pendingTasks:
            imageName = "checkmark.square.fill"
        case .completedTasks:
            imageName = "arrow.uturn.backward.square.fill"
        }
        
        let completedAction = createSwipeAction(imageName: imageName, targetAction: handleMarkTaskAsComplete(at: indexPath))
        
        return UISwipeActionsConfiguration(actions: [completedAction])
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = createSwipeAction(imageName: "xmark.app.fill", targetAction: handleDeleteCell(indexPath: indexPath))
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
        
    }
    
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    
        return .none
    }
    
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
    }
    
    
}

extension UIImage {
        func colored(in color: UIColor) -> UIImage {
            let renderer = UIGraphicsImageRenderer(size: size)
            return renderer.image { context in
                color.set()
                self.withRenderingMode(.alwaysTemplate).draw(in: CGRect(origin: .zero, size: size))
            }
        }
    }

#if canImport(SwiftUI) && DEBUG
import SwiftUI

let deviceNames: [String] = [
    "iPhone SE (2nd generation)"
]

@available(iOS 13.0, *)
struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ForEach(deviceNames, id: \.self) { deviceName in
            UIViewControllerPreview {
                UINavigationController(rootViewController: TaskVC())
                
            }.previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
#endif
