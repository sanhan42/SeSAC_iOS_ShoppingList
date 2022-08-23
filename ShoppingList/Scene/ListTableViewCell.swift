//
//  ListTableViewCell.swift
//  ShoppingList
//
//  Created by 한상민 on 2022/08/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    let checkboxButton: UIButton = {
        let view = UIButton()
        view.tintColor = .black
        return view
    }()
    
    let starButton: UIButton = {
        let view = UIButton()
        view.tintColor = .black
        return view
    }()
    
    let todoLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [checkboxButton, todoLabel, starButton])
        view.backgroundColor = .systemGray6
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.addSubview(stackView)
    }
    
    func setConstraints() {
        checkboxButton.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.leading.equalTo(8)
        }
        
        starButton.snp.makeConstraints { make in
            make.width.equalTo(25)
            make.trailing.equalTo(-12)
        }
        
        todoLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkboxButton).offset(40)
            make.trailing.equalTo(starButton).offset(-40)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).offset(0)
//            make.bottom.equalTo(contentView).offset(-10)
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
        }
    }
}
