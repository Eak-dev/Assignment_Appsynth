//
//  CategoryImageCollectionViewCell.swift
//  Assignment_Appsynth
//
//  Created by  Eak_ on 5/21/2560 BE.
//  Copyright © 2560 Eak_. All rights reserved.
//

import UIKit

class CategoryImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mNameCategry: UILabel!
    
    func setupData(name : String?){
        
        mNameCategry.text = name ?? ""
        
    }
    
}

