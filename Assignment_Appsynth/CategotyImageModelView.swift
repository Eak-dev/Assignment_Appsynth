//
//  CategotyImageModelView.swift
//  Assignment_Appsynth
//
//  Created by  Eak_ on 5/21/2560 BE.
//  Copyright © 2560 Eak_. All rights reserved.
//

import UIKit

class CategotyImageModelView: NSObject {

    var reloadCollectionViewCallback : (()->())!
    var dataCategoryList = [String]()
    
    var selectedCellIndexPath : NSIndexPath!
    var nameCategory:String!
    
    let kNumberOfSectionsInCollectionView = 1
    var numberOfItems: Int = 25
    
    var photoCategory:PXPhotoModelCategory =  PXPhotoModelCategory(rawValue: -1)!
    
    init(reloadCollectionViewCallback:@escaping (()->())){
        
        super.init()
        
        self.reloadCollectionViewCallback = reloadCollectionViewCallback
        retrieveData()
        
    }
    
    
    func retrieveData(){
        
        self.reloadCollectionViewCallback()
    }
    
    
    func numberOfItemsInSection(section : Int) -> Int {
        
        return numberOfItems
    }
    
    
    func numberOfSectionsInCollectionView() -> Int {
        
        return kNumberOfSectionsInCollectionView
    }
    
    
    func setUpCollectionViewCell(indexPath : NSIndexPath, collectionView : UICollectionView) -> UICollectionViewCell {
        
        let categoryImageCell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.kCategoryImageCollectionViewCell, for: indexPath as IndexPath) as! CategoryImageCollectionViewCell
        
        photoCategory = PXPhotoModelCategory(rawValue: indexPath.row)!
        categoryImageCell.setupData(name:"\(urlStringPhotoCategoryForPhotoCategory(photoCategory:photoCategory))")
        
        return categoryImageCell
    }
    
    func setSelectedCellIndexPath(indexPath : NSIndexPath){
        
        photoCategory = PXPhotoModelCategory(rawValue: indexPath.row)!
        nameCategory = urlStringPhotoCategoryForPhotoCategory(photoCategory:photoCategory)
        selectedCellIndexPath = indexPath
    }
    
    
    func urlStringPhotoCategoryForPhotoCategory( photoCategory:PXPhotoModelCategory) -> String {
        
        return PXAPIHelper.nameStringPhotoCategory(photoCategory)
    }
    
    func getNextViewControllerViewModel() -> ImageListModelView {
        
        let imageListModelView = ImageListModelView(photoCategory:photoCategory)
        
        return imageListModelView
        
    }
    
    
}
