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
    @Published var EnterSauceAlert: Bool = false
    
    func bookInfo(SauceNum: String) {
        
        let Headers: HTTPHeaders = [.accept("application/json")]
        
        AF.request("https://nhentai.net/api/gallery/\(SauceNum)", method: .get, headers: Headers).responseJSON { response in
            print("Working")
            
            if let Data = response.data {
                let json = try! JSON(data: Data)
                print(json)
                
                let NewDoujin = DoujinInfo()
                
                guard let Name = json["title"]["pretty"].string else {return}
                print("1")

                guard let Pages = json["num_pages"].int else {return}
                print("2")

                guard let MediaID = json["media_id"].string else {return}
                print("3")
                let Tags = List<String>()
                var count = 0
                let TagJson = json["tags"]
                
                for tag in TagJson {
                    let TheTags = DoujinTags()
                    TheTags.Name = json["tags"][count]["name"].string!
                    print(TheTags.Name)
                    NewDoujin.Tags.append(TheTags)
                    count += 1
                }
                
                NewDoujin.Name = Name
                NewDoujin.Id = SauceNum
                NewDoujin.MediaID = MediaID
                NewDoujin.NumPages = Pages
                NewDoujin.PictureString = self.getPitcture(Media: MediaID)
                NewDoujin.UniqueID = UUID().uuidString
                
                save(Doujin: NewDoujin)
                print("Saved")
            }
        }

    }
}

extension DoujinAPI{
    func getPitcture(Media: String) -> String{
        
        var ImageString = ""
        
        AF.request("https://t.nhentai.net/galleries/\(Media)/cover.p", method:.get).responseImage { (response) in
            if response.error == nil {
                if let Data = response.data{
                    ImageString = self.convertImageToBase64(UIImage(data: Data)!)
                }
            }
        }
        return ImageString
        
    }
    
    func convertImageToBase64(_ image: UIImage)-> String {
            let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            return strBase64
    }
}
