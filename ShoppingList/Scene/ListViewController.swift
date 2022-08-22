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
    
    var tasks: Results<UserList>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        tasks = localRealm.objects(UserList.self).sorted(byKeyPath: "date", ascending: false)
        configure()
    }
    
    func configure() {
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }

    @objc func addButtonClicked() {
        guard let content = mainView.todoTextField.text else { return }
        let task = UserList(content: content)
        
        try! localRealm.write({
            localRealm.add(task)
            mainView.tableView.reloadData()
        })
        
    }

}


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ListTableViewCell else {
            return UITableViewCell()
        }
        cell.todoLabel.text = tasks[indexPath.row].content
        return cell
    }
    
    
}
