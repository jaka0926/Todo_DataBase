//
//  _MainCollectionViewCell.swift
//  Todo_DataBase
//
//  Created by Jaka on 2024-07-04.
//

import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let id = "MainCollectionViewCell"
    let icon = UIButton()
    let titleLabel = UILabel()
    var itemCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(icon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(itemCountLabel)
        
        icon.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.size.equalTo(40)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        itemCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-15)
        }
        
        contentView.backgroundColor = .darkGray
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    func configureUI(_ titleData: String, _ iconData: String, iconColor: UIColor, _ itemCount: Int) {
        icon.backgroundColor = iconColor
        icon.tintColor = .white
        icon.layer.cornerRadius = 20
        let configuration = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: iconData, withConfiguration: configuration)
        icon.setImage(image, for: .normal)
        
        titleLabel.text = titleData
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .lightGray
        
        itemCountLabel.text = "\(itemCount)"
        itemCountLabel.textColor = .white
        itemCountLabel.font = .boldSystemFont(ofSize: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
