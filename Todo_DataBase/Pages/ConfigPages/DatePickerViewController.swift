//
//  DatePickerViewController.swift
//  Todo_DataBase
//
//  Created by Jaka on 2024-07-04.
//

import UIKit
import SnapKit

class DatePickerViewController: UIViewController {

    let dateSetting = UIDatePicker()
    var dateInfo: ((String) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(dateSetting)
        view.backgroundColor = .darkGray
        
        dateSetting.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        dateSetting.preferredDatePickerStyle = .wheels
        dateSetting.tintColor = .white
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let rawDate = dateSetting.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd (EEEE)"
        let formattedDate = dateFormatter.string(from: rawDate)
        dateInfo?(formattedDate)
    }
}
