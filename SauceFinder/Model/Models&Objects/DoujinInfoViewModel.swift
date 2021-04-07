//
//  DoujinInfoViewModel.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 4/6/21.
//

import Foundation
import Combine
import RealmSwift

class DoujinInfoViewModel: ObservableObject{
    var theDoujin:DoujinInfo? = nil
    var realm:Realm?
    var token: NotificationToken? = nil
    
    @ObservedResults(DoujinInfo.self) var doujins

    @Published var deleting:Bool = false
    @Published var selectedDoujin:DoujinInfo? = nil
    
    init(){
        let realm = try? Realm()
        self.realm = realm

        token = doujins.observe({ (changes) in
            switch changes{
            case .error(_):break
            case .initial(_): break
            case .update(_, deletions: _, insertions: _, modifications: _):
                self.objectWillChange.send()            }
        })
    }
    deinit {
        token?.invalidate()
    }
    
    var name: String{
        get{
            selectedDoujin!.Name
        }
    }

    var id: String {
        get {
            selectedDoujin!.Id
        }
    }
    var mediaID:String {
        get {
            selectedDoujin!.MediaID
        }
    }
    var numPages:Int{
        get {
            selectedDoujin!.NumPages
        }
    }
    var pictureString:String {
        get {
            selectedDoujin!.PictureString
        }
    }
    var uniqueId: String{
        get{
            selectedDoujin!.PictureString
        }
    }
    var similarity:String{
        get {
            selectedDoujin!.similarity
        }
    }
    var doujinTags: List<DoujinTags>{
        get {
            selectedDoujin!.Tags
        }
    }
    
    func deleteDoujin(){
            try? realm?.write{
                realm?.delete(selectedDoujin!)
            }
        deleting = false
    }
    
    func addDoujin(theDoujin: DoujinInfo){
        try? realm?.write({
            realm?.add(theDoujin)
        })
    }
}
