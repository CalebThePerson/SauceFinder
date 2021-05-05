//
//  DoujinAPI.swift
//  SauceFinder
//
//  Created by Caleb Wheeler on 12/1/20.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
import RealmSwift
import SwiftUI




class DoujinAPI:ObservableObject {
    
    static var loadingCirclePresent: Bool = false {
        didSet{
            print("updated")
        }
    }
    static var enterSauceAlert: Bool = false{
        didSet{
            print("FUCKIN UPDATED")
        }
    }
    static var progress:String = ""
    
    @Published var testing:Bool = false
    //Similar to @state, vars taht will help update views
    @Published var removing:Bool = false
    @State var cantfindAlert:Bool = false
    
    //The Doujin model
    var doujinModel = DoujinInfoViewModel()
    
    //Function that gets all the detils of the doujin
    func bookInfo(Sauces: [String]) {
        testing = true
        var theCount = 0

        DoujinAPI.progress = "\(theCount)/\(Sauces.count)"

        
        let headers: HTTPHeaders = [.accept("application/json")]
        
        for SauceNum in Sauces {
            sleep(7)
            AF.request("https://nhentai.net/api/gallery/\(SauceNum)", method: .get, headers: headers).responseJSON { response in
                print("Working")
                
                if let Data = response.data {
                        let json = try! JSON(data: Data)
                    
                    let NewDoujin = DoujinInfo()
                    
                    guard let Name = json["title"]["pretty"].string else {self.cantfindAlert.toggle(); return}
                    guard let Pages = json["num_pages"].int else {return}
                    guard let MediaID = json["media_id"].string else {return}
                    
                    
                    var count = 0
                    let TagJson = json["tags"]
                    
                    for _ in TagJson {
                        let TheTags = DoujinTags()
                        TheTags.Name = json["tags"][count]["name"].string!
                        NewDoujin.Tags.append(TheTags)
                        count += 1
                    }
                    self.getPitcture(Media: MediaID) {(newstring) in
                        NewDoujin.Name = Name
                        NewDoujin.Id = SauceNum
                        print(SauceNum)
                        NewDoujin.MediaID = MediaID
                        NewDoujin.NumPages = Pages
                        NewDoujin.PictureString = newstring
                        NewDoujin.UniqueID = UUID().uuidString
                        NewDoujin.similarity = 100
                        
                        self.doujinModel.addDoujin(theDoujin: NewDoujin)
                        DoujinAPI.progress = "\(theCount)/\(Sauces.count)"
                        theCount += 1

                    }
                }
            }

        }
        testing = false

        DoujinAPI.loadingCirclePresent = false
    }
    
    func bookInfoWithName(with theName: String,the similarity: String){
//        DoujinAPI.loadingCirclePresent = true
        testing = true
        let headers: HTTPHeaders = [.accept("application/json")]
        
        AF.request("https://nhentai.net/api/galleries/search?query=\(theName)&page=PAGE=1&sort=SORT=recent", method: .get, headers: headers).responseJSON {response in
            if let Data = response.data{
                let json = try! JSON(data: Data)
                
                let NewDoujin = DoujinInfo()
                
                guard let Name = json["result"][0]["title"]["pretty"].string else {self.cantfindAlert.toggle();print(self.cantfindAlert);return}
                guard let Pages = json["result"][0]["num_pages"].int else {return}
                guard let MediaID = json["result"][0]["media_id"].string else {return}
                guard let SauceNum = json["result"][0]["id"].int else {return}
                
                
                var count = 0
                let TagJson = json["result"][0]["tags"]
                
                for _ in TagJson {
                    let TheTags = DoujinTags()
                    TheTags.Name = json["result"][0]["tags"][count]["name"].string!
                    //                    print(TheTags.Name)
                    NewDoujin.Tags.append(TheTags)
                    count += 1
                }
                self.getPitcture(Media: MediaID) {(newstring) in
                    NewDoujin.Name = Name
                    NewDoujin.Id = "\(SauceNum)"
                    NewDoujin.MediaID = MediaID
                    NewDoujin.NumPages = Pages
                    NewDoujin.PictureString = newstring
                    NewDoujin.UniqueID = UUID().uuidString
                    NewDoujin.similarity = Double(similarity)!
                    
                    self.doujinModel.addDoujin(theDoujin: NewDoujin)
                    print("Saved")
                    DoujinAPI.loadingCirclePresent = false
                }
            }
        }
    }
}

