//
//  SaveAndSuch.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 12/1/20.
//

import Foundation
import RealmSwift

let realm = try! Realm()

func save(Doujin : DoujinInfo) {
    do {
        try realm.write {
            realm.add(Doujin)
        }
        
    } catch {
        print("The erorr is \(error)")
    }
    print("Saved")

}

func delete(doujin: DoujinInfo){
    do {
        try realm.write{
            realm.delete(doujin)
        }
    }
    catch {
        print("There was an error \(error)")
    }
    print("Deleted")
}
