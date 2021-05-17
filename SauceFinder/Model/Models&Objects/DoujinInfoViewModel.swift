//
//  DoujinInfoViewModel.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 4/6/21.
//

import Foundation
import Combine
import RealmSwift

enum colorSquare:Identifiable{
    var id: Int{
        hashValue
    }
    
    case green
    case yellow
    case red
}

class DoujinInfoViewModel: ObservableObject{
    var theDoujin:DoujinInfo? = nil
    var realm:Realm?
    var token: NotificationToken? = nil
    
    @ObservedResults(DoujinInfo.self) var doujins
    
    @Published var deleting:Bool = false
    @Published var selectedDoujin:DoujinInfo? = nil
    @Published var loading:Bool = false
    
    
    
    init(){
        let realm = try? Realm()
        self.realm = realm
        self.realm?.autorefresh == true
        
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
    var similarity:Double{
        get {
            selectedDoujin!.similarity
        }
    }
    var color:colorSquare{
        get{
            switch selectedDoujin!.similarity{
            case 0...50:
                return .red
            case 50...75:
                return .yellow
            case 75...100:
                return .green
            default:
                return .green
            }
        }
    }
    
    var doujinTags: List<DoujinTags>{
        get {
            selectedDoujin!.Tags
        }
    }
    
    func deleteDoujin(){
        if selectedDoujin?.isInvalidated == false{
            try? realm?.write{
                realm?.delete(selectedDoujin!)
            }
            deleting = false
        }
    }
    
    func easyDelete(at index: Int){
        
        //        let realm = doujins[index].realm
        try? realm?.write({
            self.realm?.delete(self.doujins[index])
            
            
        })
        print("gone")
        
    }
    
    func addDoujin(theDoujin: DoujinInfo){
        try? realm?.write({
            realm?.add(theDoujin)
        })
        
    }
    
}
