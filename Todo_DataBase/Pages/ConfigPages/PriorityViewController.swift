//
//  PriorityViewController.swift
//  Todo_DataBase
//
//  Created by Jaka on 2024-07-04.
//

import UIKit
import SnapKit

class PriorityViewController: UIViewController {

    let prioritySetting = UISegmentedControl()
    var priorityInfo: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(prioritySetting)
        view.backgroundColor = .darkGray
       
        prioritySetting.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        prioritySetting.backgroundColor = .gray
        prioritySetting.insertSegment(withTitle: "낮음", at: 0, animated: true)
        prioritySetting.insertSegment(withTitle: "보통", at: 1, animated: true)
        prioritySetting.insertSegment(withTitle: "높음", at: 2, animated: true)
        prioritySetting.selectedSegmentIndex = 1
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        priorityInfo?(prioritySetting.selectedSegmentIndex)
    }
}
