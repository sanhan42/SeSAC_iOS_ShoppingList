//
//  ListViewController.swift
//  ShoppingList
//
//  Created by 한상민 on 2022/08/22.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController {
    let localRealm = try! Realm()
    let mainView = ListMainView()
    
    var tasks: Results<UserList>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTasks()
        configure()
    }
    
    func fetchTasks() {
        tasks = localRealm.objects(UserList.self).sorted(byKeyPath: "date", ascending: false)
    }
    
    func configure() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.todoTextField.delegate = self
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }

    @objc func addButtonClicked() {
        guard let content = mainView.todoTextField.text, content != "" else {
            mainView.todoTextField.text = nil
            return
        }
        mainView.todoTextField.text = nil
        let task = UserList(content: content)
        
        try! localRealm.write({
            localRealm.add(task)
            mainView.tableView.reloadData()
        })
        
    }

}


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, handler in
            do {
                try self.localRealm.write({
                    self.localRealm.delete(self.tasks[indexPath.row])
                })
                self.fetchTasks()
            } catch {
                print("Check Update Fail")
            }
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ListTableViewCell else {
            return UITableViewCell()
        }
        let chckImage = tasks[indexPath.row].check ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        cell.checkboxButton.tag = indexPath.row
        cell.starButton.tag = indexPath.row
        cell.checkboxButton.setImage(chckImage, for: .normal)
        cell.checkboxButton.addTarget(self, action: #selector(checkboxButtonClicked(button:)), for: .touchUpInside)
        let starImage = tasks[indexPath.row].favorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        cell.starButton.setImage(starImage, for: .normal)
        cell.starButton.addTarget(self, action: #selector(starButtonClicked(button:)), for: .touchUpInside)
        cell.todoLabel.text = tasks[indexPath.row].content
        return cell
    }
    
    @objc func checkboxButtonClicked(button: UIButton) {
        do {
            try localRealm.write({
                self.tasks[button.tag].check = !self.tasks[button.tag].check
            })
            fetchTasks()
        } catch {
            print("Check Update Fail")
        }
    }
    
    @objc func starButtonClicked(button: UIButton) {
        do {
            try localRealm.write({
                self.tasks[button.tag].favorite = !self.tasks[button.tag].favorite
            })
            fetchTasks()
        } catch {
            print("Star Update Fail")
        }
    }
}

extension ListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addButtonClicked()
        return true
    }
}
