//
//  ListMainView.swift
//  ShoppingList
//
//  Created by 한상민 on 2022/08/22.
//

import UIKit
import SnapKit

class ListMainView: UIView {
    let todoTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "무엇을 구매하실 건가요?"
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        return view
    }()
    
    let addButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemGray5
        view.setTitle("추가", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.layer.cornerRadius = 8
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.layer.cornerRadius = 8
        view.register(ListTableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.backgroundColor = .systemBackground
        [todoTextField, addButton, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        todoTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(88)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerY.equalTo(todoTextField)
            make.width.equalTo(60)
            make.trailing.equalTo(todoTextField).offset(-12)
        }
       
        tableView.rowHeight = 45
        tableView.snp.makeConstraints { make in
            make.top.equalTo(todoTextField).offset(100)
            make.bottom.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
    }
}
