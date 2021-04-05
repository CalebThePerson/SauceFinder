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


class DoujinAPI:ObservableObject {
    @Published var enterSauceAlert: Bool = false
    @Published var loadingCirclePresent: Bool = false
    @Published var removing:Bool = false
    
    
    //Function that gets all the detils of the doujin
    func bookInfo(SauceNum: String) {
        self.loadingCirclePresent = true
        
        let headers: HTTPHeaders = [.accept("application/json")]
        
        AF.request("https://nhentai.net/api/gallery/\(SauceNum)", method: .get, headers: headers).responseJSON { response in
            print("Working")
            
            if let Data = response.data {
                let json = try! JSON(data: Data)
                
                let NewDoujin = DoujinInfo()
                
                guard let Name = json["title"]["pretty"].string else {return}
                
                guard let Pages = json["num_pages"].int else {return}
                
                guard let MediaID = json["media_id"].string else {return}
                let Tags = List<String>()
                var count = 0
                let TagJson = json["tags"]
                
                for tag in TagJson {
                    let TheTags = DoujinTags()
                    TheTags.Name = json["tags"][count]["name"].string!
                    //                    print(TheTags.Name)
                    NewDoujin.Tags.append(TheTags)
                    count += 1
                }
                self.getPitcture(Media: MediaID) {(newstring) in
                    NewDoujin.Name = Name
                    NewDoujin.Id = SauceNum
                    NewDoujin.MediaID = MediaID
                    NewDoujin.NumPages = Pages
                    NewDoujin.PictureString = newstring
                    NewDoujin.UniqueID = UUID().uuidString
                    NewDoujin.similarity = "100%"

                    
                    save(Doujin: NewDoujin)
                    print("Saved")
                    self.loadingCirclePresent.toggle()
                }
            }
        }
    }
    
    func bookInfoWithName(with theName: String,the similarity: String){
        let headers: HTTPHeaders = [.accept("application/json")]
        
        AF.request("https://nhentai.net/api/galleries/search?query=\(theName)&page=PAGE=1&sort=SORT=recent", method: .get, headers: headers).responseJSON {response in
            if let Data = response.data{
                let json = try! JSON(data: Data)
                print(json)
                
                let NewDoujin = DoujinInfo()
                
                guard let Name = json["result"][0]["title"]["pretty"].string else {return}
                print("boom")
                guard let Pages = json["result"][0]["num_pages"].int else {return}
                print("boom")

                guard let MediaID = json["result"][0]["media_id"].string else {return}
                print("boom")

                guard let SauceNum = json["result"][0]["id"].int else {return}
                print("bam")

                
                let Tags = List<String>()
                var count = 0
                let TagJson = json["result"][0]["tags"]
                
                for tag in TagJson {
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
                    NewDoujin.similarity = "\(similarity)%"
                    
                    save(Doujin: NewDoujin)
                    print("Saved")
                }
            }
        }
    }
}

extension DoujinAPI{
    //The Function that grabs the picture of the sauce
    func getPitcture(Media: String,completion: @escaping (String) -> Void){
        
        var ImageString = ""
        
        AF.request("https://t.nhentai.net/galleries/\(Media)/cover.jpg").responseImage { response in
            
            if case .success(let image) = response.result {
                print("Image downlaoded \(image)")
                
                ImageString = self.convertImageToBase64(image)
                completion(ImageString)
                
                
            }
        }
        
    }
    
    func convertImageToBase64(_ image: UIImage)-> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        return strBase64
    }
}
