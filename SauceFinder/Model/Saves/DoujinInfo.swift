//
//  DoujinInfo.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 12/1/20.
//

import Foundation
import RealmSwift

class DoujinInfo:Object, Identifiable {
    @objc dynamic var Name:String = ""
    @objc dynamic var Id: String = ""
    @objc dynamic var MediaID:String = ""
    @objc dynamic var NumPages: Int = 0
    @objc dynamic var PictureString:String = ""
    @objc dynamic var UniqueID:String = ""
    @objc dynamic var similarity:String = ""
    var Tags = List<DoujinTags>()
}
