//
//  ListTableViewCell.swift
//  ShoppingList
//
//  Created by 한상민 on 2022/08/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    let checkboxImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "checkmark.square")
        view.tintColor = .black
        return view
    }()
    
    let starImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star")
        view.tintColor = .black
        return view
    }()
    
    let todoLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [checkboxImage, todoLabel, starImage])
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
        checkboxImage.snp.makeConstraints { make in
            make.width.equalTo(25)
        }
        starImage.snp.makeConstraints { make in
            make.width.equalTo(25)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
        }
    }
}
