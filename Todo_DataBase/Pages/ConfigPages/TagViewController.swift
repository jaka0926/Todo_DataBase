//
//  TagViewController.swift
//  Todo_DataBase
//
//  Created by Jaka on 2024-07-04.
//

import UIKit
import SnapKit

class TagViewController: UIViewController {

    let tagText = UITextField()
    var tagInfo: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tagText)
        view.backgroundColor = .darkGray
        
        tagText.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        tagText.backgroundColor = .gray
        tagText.textColor = .white
        tagText.layer.cornerRadius = 10
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        tagInfo?(tagText.text ?? "")
    }
}
