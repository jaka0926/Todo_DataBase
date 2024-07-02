//
//  RealmModel.swift
//  Todo_DataBase
//
//  Created by Jaka on 2024-07-02.
//

import Foundation
import RealmSwift

class MainTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var textContent: String?
    @Persisted var deadLine: Date?
    
    convenience init(title: String, textContent: String?, deadLine: Date?) {
        self.init()
        self.id = id
        self.title = title
        self.textContent = textContent
        self.deadLine = deadLine
    }
}
