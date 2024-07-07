//
//  _TodoListTableViewCell.swift
//  Todo_DataBase
//
//  Created by Jaka on 2024-07-02.
//

import UIKit
import SnapKit

class TodoListTableViewCell: UITableViewCell {
    
    static let id = "TodoListTableViewCell"
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let subLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(subLabel)
        
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        contentLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        subLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(titleLabel)
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
        }
    }
    func configureUI() {
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 18)
    
        contentLabel.textColor = .darkGray
        contentLabel.font = .boldSystemFont(ofSize: 17)

        subLabel.textColor = .darkGray
    }
}
