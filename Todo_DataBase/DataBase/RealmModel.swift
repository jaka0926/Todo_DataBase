//
//  RealmModel.swift
//  Todo_DataBase
//
//  Created by Jaka on 2024-07-02.
//

import Foundation
import RealmSwift

class Folder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var iconImage: String
    @Persisted var iconBg: String?
    @Persisted var detail: List<MainTable>
}

class MainTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var textContent: String?
    @Persisted var deadLine: String?
    @Persisted var priority: String?
    @Persisted var tag: String?
    
    @Persisted(originProperty: "detail") var main: LinkingObjects<Folder>
    
    convenience init(title: String, textContent: String?, deadLine: String?, priority: String?, tag: String?) {
        self.init()
        self.id = id
        self.title = title
        self.textContent = textContent
        self.deadLine = deadLine
        self.priority = priority
        self.tag = tag
    }
}
