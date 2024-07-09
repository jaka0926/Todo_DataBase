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
    var dateInfo: ((Date, String) -> Void)?
    var selectedDate = UILabel()
    var viewModel = DatePickerModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(dateSetting)
        view.addSubview(selectedDate)
        view.backgroundColor = .darkGray
        
        dateSetting.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        selectedDate.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateSetting.snp.bottom).offset(100)
        }
        dateSetting.preferredDatePickerStyle = .wheels
        dateSetting.tintColor = .white
        dateSetting.datePickerMode = .date
        dateSetting.preferredDatePickerStyle = .compact
        dateSetting.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        selectedDate.textColor = .white
        dateChanged()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dateInfo?(dateSetting.date, viewModel.outputValue)
    }
    
    @objc func dateChanged() {
        let rawDate = dateSetting.date
        viewModel.inputValue = rawDate
        selectedDate.text = viewModel.outputValue
    }
}
