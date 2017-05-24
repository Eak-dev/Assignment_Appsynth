//
//  CategoryImageViewController.swift
//  Assignment_Appsynth
//
//  Created by  Eak_ on 5/21/2560 BE.
//  Copyright © 2560 Eak_. All rights reserved.
//

import UIKit
import GreedoLayout

class CategoryImageViewController: UIViewController {
   
    private var _collectionViewSizeCalculator: GreedoCollectionViewLayout!
    var collectionViewSizeCalculator: GreedoCollectionViewLayout! {
        set {
            _collectionViewSizeCalculator = newValue
        }
        get {
            
            if _collectionViewSizeCalculator == nil {
                _collectionViewSizeCalculator = GreedoCollectionViewLayout.init(collectionView: self.mCategoryImageCollentionView)
                _collectionViewSizeCalculator.dataSource = self
            }
            return _collectionViewSizeCalculator
            
        }
    }
    
    private var _layout:UICollectionViewFlowLayout!
    var layout:UICollectionViewFlowLayout{
        set {
            _layout = newValue
        }
        get {
            
            if _layout == nil {
                _layout = UICollectionViewFlowLayout()
                _layout.minimumInteritemSpacing  = 5.0
                _layout.minimumLineSpacing = 5.0
                _layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)
            }
            return _layout
            
        }
    }
    
    var viewModel : CategotyImageModelView!
    
    @IBOutlet weak var mCategoryImageCollentionView: UICollectionView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupColllectionView()
        configureCollectionView()
        
        viewModel = CategotyImageModelView(reloadCollectionViewCallback : reloadCollectionViewData)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceRotated(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupColllectionView(){
        
        mCategoryImageCollentionView.delegate = self
        mCategoryImageCollentionView.dataSource = self
        
    }
    
    //method is called by the viewModel when it has new data
    func reloadCollectionViewData(){
        
        mCategoryImageCollentionView.reloadData()
        
    }
    
    private func configureCollectionView() {
        
        let size  = self.mCategoryImageCollentionView.frame.size
        collectionViewSizeCalculator.rowMaximumHeight = size.height / 4
        
        mCategoryImageCollentionView.collectionViewLayout = layout
    }

    func deviceRotated(_ notification: Notification) {
        let device = notification.object as! UIDevice
        let orientation = device.orientation
        getOrientation(orientation: orientation)
    }
    
    func getOrientation(orientation: UIDeviceOrientation) {
        
    
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == Constants.kToImageViewController {
            
            let nextVC = segue.destination as! ImageListViewController
            nextVC.title     = viewModel.nameCategory
            nextVC.viewModel = viewModel.getNextViewControllerViewModel()
            
        }
        
    }
    
    @IBAction func backToCategoryImageView(segue: UIStoryboardSegue){
        
    }
}

extension CategoryImageViewController: UICollectionViewDataSource,GreedoCollectionViewLayoutDataSource,UICollectionViewDelegateFlowLayout {
  
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return viewModel.numberOfSectionsInCollectionView()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfItemsInSection(section: section)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return viewModel.setUpCollectionViewCell(indexPath: indexPath as NSIndexPath, collectionView: mCategoryImageCollentionView)
        
    }
    
    func greedoCollectionViewLayout(_ layout: GreedoCollectionViewLayout!, originalImageSizeAt indexPath: IndexPath!) -> CGSize {
        return CGSize(width: 0.1, height: 0.1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionViewSizeCalculator.sizeForPhoto(at: indexPath as IndexPath!)
    }
    

}

extension CategoryImageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.setSelectedCellIndexPath(indexPath: indexPath as NSIndexPath)
        
        performSegue(withIdentifier: Constants.kToImageViewController, sender: self)
        
    }
    
}

