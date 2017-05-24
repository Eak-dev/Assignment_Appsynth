    //
//  ImageListModelView.swift
//  Assignment_Appsynth
//
//  Created by  Eak_ on 5/22/2560 BE.
//  Copyright © 2560 Eak_. All rights reserved.
//

import UIKit
import SKPhotoBrowser
    
class ImageListModelView: NSObject {
    
    var reloadCollectionViewCallback : (()->())!
    var dataCategoryList = [CategoryImageModel]()
    var photoCategory:PXPhotoModelCategory!
    var imagesPreview = [SKPhotoProtocol]()
    
    var selectedCellIndexPath : NSIndexPath!
    var nameCategory:String!
    var countPage:Int! = 1
    var isLoadingData:Bool! = false
    var finished:Bool! = false
    
    let kNumberOfSectionsInCollectionView = 1

    
    init(reloadCollectionViewCallback:@escaping (()->())){
        
        super.init()
    
        self.reloadCollectionViewCallback = reloadCollectionViewCallback
        retrieveData(page: 1)
        
    }
    
    init(photoCategory:PXPhotoModelCategory){
        
        self.photoCategory = photoCategory
        
    }
    
    func reloadCollectionViewCallbackAction(reloadCollectionViewCallback:@escaping (()->())) {
        self.reloadCollectionViewCallback = reloadCollectionViewCallback
        retrieveData(page: 1)
    }

    func retrieveData(page:Int){
        
        isLoadingData = true
        countPage = page
        
        PXRequest.forPhotosOf(self.photoCategory, page:page, photoSizes: PXPhotoModelSize(rawValue: (1 << 3))) { (results,error) in
            print("")
            self.isLoadingData = false
            let dataResults:NSArray = results!["photos"] as? NSArray  ?? []
            if (dataResults.count > 0){
                let total_pages = results!["total_pages"] as! Int
                if (total_pages == self.countPage){
                    self.finished = true
                }
                
                for data in dataResults {
                    let imageData = CategoryImageModel()
                    imageData .setupWithDict(dict: data as! NSDictionary)
                    
                    self.dataCategoryList .append(imageData)
                }
                
                self.imagesPreview = self.createLocalPhotos()
                self.reloadCollectionViewCallback()
            }
      
        }
    }
    
    func numberOfItemsInSection() -> Int {
        
        if self.dataCategoryList.count == 0 {
            return 0
        }
        return self.dataCategoryList.count
    }
    
    
    func numberOfSectionsInCollectionView() -> Int {
        
        return kNumberOfSectionsInCollectionView
    }
    
    func categoryImageModelOfIndex(index : Int) -> CategoryImageModel {
        
        return self.dataCategoryList[index];
    }
    
    
    func getCountPage() -> Int {
        
        countPage = countPage + 1
        return countPage
    }
    
    func setUpCollectionViewCell(indexPath : NSIndexPath, collectionView : UICollectionView) -> UICollectionViewCell {
        
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdenImageViewCollectionViewCell, for: indexPath as IndexPath) as! ImageViewCollectionViewCell
        
        if self.dataCategoryList.count > 0 {
            let categoryImageModel:CategoryImageModel = self.dataCategoryList[indexPath.row]
            imageCell.setupData(categoryImageModel:categoryImageModel)
        }
        
        return imageCell
    }
    
    func setUpImageParallaxCellCollectionViewCell(indexPath : NSIndexPath, collectionView : UICollectionView) -> ImageParallaxCellCollectionViewCell {
        
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.kIdenImageParallaxCellCollectionViewCell, for: indexPath as IndexPath) as! ImageParallaxCellCollectionViewCell
        
        if self.dataCategoryList.count > 0 {
            let categoryImageModel:CategoryImageModel = self.dataCategoryList[indexPath.row]
            imageCell.setupData(categoryImageModel:categoryImageModel)
        }
        return imageCell
    }
    
    func setSelectedCellIndexPath(indexPath : NSIndexPath){
        
        let photoCategory:PXPhotoModelCategory = PXPhotoModelCategory(rawValue: indexPath.row)!
        nameCategory = urlStringPhotoCategoryForPhotoCategory(photoCategory:photoCategory)
        selectedCellIndexPath = indexPath
    }
    
    
    func urlStringPhotoCategoryForPhotoCategory( photoCategory:PXPhotoModelCategory) -> String {
        
        return PXAPIHelper.nameStringPhotoCategory(photoCategory)
    }
   
    func setPhotoCategory( photoCategory:PXPhotoModelCategory){
        
        self.photoCategory = photoCategory
    }
    
    
    func createLocalPhotos() -> [SKPhotoProtocol] {
        return (0..<self.numberOfItemsInSection()).map { (i: Int) -> SKPhotoProtocol in
            
            let categoryImageModel:CategoryImageModel = self.dataCategoryList[i]
            let imagesList:[ImagesModel] = categoryImageModel.images.imagesList
            let images :ImagesModel! = imagesList.first
            let photo = SKPhoto.photoWithImageURL(images.url)
            photo.caption = categoryImageModel.name
            photo.contentMode = .scaleAspectFit
            
            return photo
        }
    }
    
    
}
