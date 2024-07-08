//
//  TableRepository.swift
//  Todo_DataBase
//
//  Created by Jaka on 2024-07-08.
//

import Foundation
import RealmSwift

final class TableRepository {
    
    private let realm = try! Realm()
    
    func detectRealmURL() {
        print(realm.configuration.fileURL ?? "")
    }
    
    func fetchFolder() -> [Folder] {
        let value = realm.objects(Folder.self)
        return Array(value)
    }
    
    func fetchAll() -> [MainTable] {
        let value = realm.objects(MainTable.self)
        return Array(value)
    }
    
    func createItem(_ data: MainTable, folder: Folder) {
        
        do {
            try realm.write {
                folder.detail.append(data)
                
                print("Realm create succeeded")
            }
        }
        catch {
            print("Realm save error")
        }
    }
    
    func deleteItem(_ data: MainTable) {
        try! realm.write {
            realm.delete(data)
            print("Realm Deleted")
        }
    }
}
