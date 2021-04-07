//
//  DoujinTags.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 12/1/20.
//

import Foundation
import RealmSwift

class DoujinTags:Object {
    @objc dynamic var Name:String = ""
    var ParentDoujin = LinkingObjects(fromType: DoujinInfo.self, property: "Tags")
}
