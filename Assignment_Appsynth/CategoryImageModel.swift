//
//  CategoryImageModel.swift
//  Assignment_Appsynth
//
//  Created by  Eak_ on 5/21/2560 BE.
//  Copyright © 2560 Eak_. All rights reserved.
//

import UIKit

class CategoryImageModel: NSObject {
    
    var perture:String! = ""
    var camera:String! = ""
    var category:Float! = 0
    var collectionsCount:Int! = 0
    var commentsCount:Int! = 0
    var converted:Int! = 0
    var convertedBits:Int! = 0
    var createdAt:String! = ""
    var cropVersion:Int! = 0
    var descriptionCat:String! = ""
    var favoritesCount:Int! = 0
    var focalLength:String! = ""
    var forSale:Bool! = false
    var forSaleDate:String! = ""
    var height:Int! = 0
    var hiResUploaded:Int! = 0
    var highestRating:Int! = 0
    var highestRatingDate:String! = ""
    var id:Int! = 0
    var imageFormat:String! = ""
    var imageUrl:[String]! = [String]()
    var images :ImagesModel! = ImagesModel()
    var isFreePhoto:Bool! = false
    var iso:String! = ""
    var latitude:Float! = 0
    var lens:String! = ""
    var licenseType:Int! = 0
    var licensingRequested:Bool! = false
    var licensingSuggested:Bool! = false
    var location:String! = ""
    var longitude:String! = ""
    var name:String! = ""
    var nsfw:Bool! = false
    var positiveVotesCount:Int! = 0
    var privacy:Bool! = false
    var profile:Bool! = false
    var rating:String! = ""
    var salesCount:Int! = 0
    var shutterSpeed:String! = ""
    var status:Int! = 0
    var takenAt:String! = ""
    var timesViewed:Int! = 0
    var url:String! = ""
    var user:UserModel! = UserModel()
    var userId:Int! = 0
    var votesCount:Int! = 0
    var watermark:Bool! = false
    var width:Int! = 0
    
    
    func setupWithDict(dict: NSDictionary) {
        
        self.perture = dict["aperture"] as? String ?? ""
        self.camera = dict["camera"] as? String ?? ""
        self.category = dict["category"] as? Float ?? 0.0
        self.collectionsCount = dict["collections_count"] as? Int ?? 0
        self.commentsCount = dict["comments_count"] as? Int ?? 0
        self.converted = dict["converted"] as? Int ?? 0
        self.convertedBits = dict["converted_bits"] as? Int ?? 0
        self.createdAt = dict["created_at"] as? String ?? ""
        self.cropVersion = dict["crop_version"] as? Int ?? 0
        self.descriptionCat = dict["description"] as? String ?? ""
        self.favoritesCount = dict["favorites_count"] as? Int ?? 0
        self.focalLength = dict["focal_length"] as? String ?? ""
        self.forSale = dict["for_sale"] as? Bool ?? false
        self.forSaleDate = dict["for_sale_date"] as? String ?? ""
        self.height = dict["height"] as? Int ?? 0
        self.hiResUploaded = dict["hi_res_uploaded"] as? Int ?? 0
        self.highestRating = dict["highest_rating"] as? Int ?? 0
        self.highestRatingDate = dict["highest_rating_date"] as? String ?? ""
        self.id = dict["id"] as? Int ?? 0
        self.imageFormat = dict["image_format"] as? String ?? ""
        self.imageUrl = dict["image_url"] as! [String]
        self.images.setupWithDictList(dict:dict["images"] as! NSArray)
        self.isFreePhoto = dict["is_free_photo"] as? Bool ?? false
        self.iso = dict["iso"] as? String ?? ""
        self.latitude = dict["latitude"] as? Float ?? 0.0
        self.lens = dict["lens"] as? String ?? ""
        self.licenseType = dict["license_type"] as? Int ?? 0
        self.licensingRequested = dict["licensing_requested"] as? Bool ?? false
        self.licensingSuggested = dict["licensing_suggested"] as? Bool ?? false
        self.location = dict["location"] as? String ?? ""
        self.longitude = dict["longitude"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.nsfw = dict["nsfw"] as? Bool ?? false
        self.positiveVotesCount = dict["positive_votes_count"] as? Int ?? 0
        self.privacy = dict["privacy"] as? Bool ?? false
        self.profile = dict["profile"] as? Bool ?? false
        self.rating = dict["rating"] as? String ?? ""
        self.salesCount = dict["sales_count"] as? Int ?? 0
        self.shutterSpeed = dict["shutter_speed"] as? String ?? ""
        self.status = dict["status"] as? Int ?? 0
        self.takenAt = dict["taken_at"] as? String ?? ""
        self.timesViewed = dict["times_viewed"] as? Int ?? 0
        self.url = dict["url"] as? String ?? ""
        self.user.setupWithDict(dict:dict["user"] as! NSDictionary)
        self.userId = dict["user_id"] as? Int ?? 0
        self.votesCount = dict["votes_count"] as? Int ?? 0
        self.watermark = dict["watermark"] as? Bool ?? false
        self.width = dict["width"] as? Int ?? 0
        
    }

}

class ImagesModel: NSObject {
    
    var format:String = ""
    var httpsUrl:String = ""
    var size:CGSize = CGSize.zero
    var url:String = ""
    var imagesList:[ImagesModel] = [ImagesModel]()
    
    func setupWithDictList(dict: NSArray){
        
        for value in dict {
            let images:ImagesModel = ImagesModel()
            images.setupWithDict(dict: value as! NSDictionary)
            self.imagesList.append(images)
        }
        
    }
    
    func setupWithDict(dict: NSDictionary) {
        
        self.format = dict["format"] as? String ?? ""
        self.httpsUrl = dict["https_url"] as? String ?? ""
        self.size =  CGSize.zero
        self.url = dict["url"] as? String ?? ""
        
        
        
    }
    
}

class UserModel: NSObject {
    
    var affection:Int = 0
    var avatars :AvatarsModel = AvatarsModel()
    var city:String = ""
    var country:String = ""
    var coverUrl:String = ""
    var firstname:String = ""
    var fullname:String = ""
    var id:Int = 0
    var lastname:String = ""
    var storeOn:Int = 0
    var upgradeStatus:Int = 0
    var username:String = ""
    var userpicHttpsUrl:String = ""
    var userpicUrl:String = ""
    var usertype:Int = 0
    
    func setupWithDict(dict: NSDictionary) {
        
        self.affection = dict["affection"] as? Int ?? 0
        self.avatars.setupWithDict(dict:dict["avatars"] as! NSDictionary)
        self.city = dict["city"] as? String ?? ""
        self.country = dict["country"] as? String ?? ""
        self.coverUrl = dict["cover_url"] as? String ?? ""
        self.firstname = dict["firstname"] as? String ?? ""
        self.fullname = dict["fullname"] as? String ?? ""
        self.id = dict["id"] as? Int ?? 0
        self.lastname = dict["lastname"] as? String ?? ""
        self.storeOn = dict["store_on"] as? Int ?? 0
        self.upgradeStatus = dict["upgrade_status"] as? Int ?? 0
        self.username = dict["username"] as? String ?? ""
        self.userpicHttpsUrl = dict["userpic_https_url"] as? String ?? ""
        self.userpicUrl = dict["userpic_url"] as? String ?? ""
        self.usertype = dict["usertype"] as? Int ?? 0
    }
    
}


class AvatarsModel: NSObject {
    var defaultAvatar:String = ""
    var large:String = ""
    var small:String = ""
    var tiny:String = ""
    
    func setupWithDict(dict: NSDictionary) {
        
        self.defaultAvatar = dict["default"] as? String ?? ""
        self.large  = dict["large"] as? String ?? ""
        self.small = dict["small"] as? String ?? ""
        self.tiny = dict["tiny"] as? String ?? ""
    }
    
}


