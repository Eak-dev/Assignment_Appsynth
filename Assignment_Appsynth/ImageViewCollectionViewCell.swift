//
//  ImageViewCollectionViewCell.swift
//  Assignment_Appsynth
//
//  Created by  Eak_ on 5/22/2560 BE.
//  Copyright © 2560 Eak_. All rights reserved.
//

import UIKit

class ImageViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mNameImage: UILabel!
    @IBOutlet weak var mImageView: UIImageView!
    
    let animationDuration: TimeInterval = 0.25
    let switchingInterval: TimeInterval = 3
    
    func setupData(categoryImageModel : CategoryImageModel?){
        
        mNameImage.text = categoryImageModel?.name
        
        let imagesList:[ImagesModel] = categoryImageModel!.images.imagesList
        let images :ImagesModel! = imagesList.first

        animateImageView()
        mImageView.sd_setImage(with: URL(string:images.url)) { (image, error, imageCacheType, imageUrl) in

            if image != nil {
               self.mImageView.image = image
            }
        }
        
    }
    
    func animateImageView() {
        
        let transition = CATransition()
        transition.duration = 0.25
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.mImageView.layer.add(transition, forKey: kCATransition)
    }
    
    
}
