//
//  ImageParallaxCellCollectionViewCell.swift
//  Assignment_Appsynth
//
//  Created by  Eak_ on 5/23/2560 BE.
//  Copyright © 2560 Eak_. All rights reserved.
//

import UIKit

class ImageParallaxCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mNameImage: UILabel!
    @IBOutlet weak var mImageView: UIImageView!
    
    func setupData(categoryImageModel : CategoryImageModel?){
        
        mNameImage.text = categoryImageModel?.name
        
        let imagesList:[ImagesModel] = categoryImageModel!.images.imagesList
        let images :ImagesModel! = imagesList.first
        
        mImageView.sd_setImage(with: URL(string:images.url)) { (image, error, imageCacheType, imageUrl) in
            
            if image != nil {
                self.mImageView.image = image
            }
        }
        
    }
    
}
