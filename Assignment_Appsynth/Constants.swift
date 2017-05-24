//
//  Constants.swift
//  InfiniteCollectionView
//
//  Created by Arun Kumar.P on 3/8/16.
//  Copyright © 2016 ArunKumar.P. All rights reserved.
//

import Foundation

enum LoadMoreStatus{
    case loading
    case finished
    case haveMore
}

struct Constants {
    
    static let kLoadMoreVerticalCollectionFooterViewCellIdentifier = "LoadMoreVerticalCollectionFooterViewCellIdentifier"
    
    static let kToImageViewController = "toImageViewController"
    
    static let kCategoryImageCollectionViewCell = "CategoryImageCollectionViewCell"
    static let kIdenImageViewCollectionViewCell = "ImageViewCollectionViewCell"
    static let kIdenImageParallaxCellCollectionViewCell = "ImageParallaxCellCollectionViewCell"
}
