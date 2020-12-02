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
    @objc dynamic var NumPages: String = ""
    @objc dynamic var PictureString:String = ""
    var Tags = List<DoujinTags>()
}
