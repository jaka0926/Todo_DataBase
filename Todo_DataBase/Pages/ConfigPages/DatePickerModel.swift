//
//  DatePickerModel.swift
//  Todo_DataBase
//
//  Created by Jaka on 2024-07-10.
//

import Foundation

class DatePickerModel {
    
    var inputValue = Date() {
        didSet {
            formatter(inputValue)
        }
    }
    var outputValue = ""
    
    func formatter(_ inputData: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd (EEEE)"
        outputValue = dateFormatter.string(from: inputData)
        return
    }
}
