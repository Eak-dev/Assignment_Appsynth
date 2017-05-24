//
//  ImageListViewController.swift
//  Assignment_Appsynth
//
//  Created by  Eak_ on 5/22/2560 BE.
//  Copyright © 2560 Eak_. All rights reserved.
//

import UIKit
import GreedoLayout
import SDWebImage
import SKPhotoBrowser

class ImageListViewController: UIViewController {
    
    private var _collectionViewSizeCalculator: GreedoCollectionViewLayout!
    var collectionViewSizeCalculator: GreedoCollectionViewLayout! {
        set {
            _collectionViewSizeCalculator = newValue
        }
        get {
            
            if _collectionViewSizeCalculator == nil {
                _collectionViewSizeCalculator = GreedoCollectionViewLayout.init(collectionView: self.mImageListCollentionView)
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
                _layout.sectionInset = UIEdgeInsetsMake(10.0, 5.0, 5.0, 5.0)
            }
            return _layout
            
        }
    }
    
    var loadingStatus = LoadMoreStatus.haveMore
    var viewModel : ImageListModelView!
    
    
    @IBOutlet weak var mImageListCollentionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        
        viewModel.reloadCollectionViewCallbackAction(reloadCollectionViewCallback: reloadCollectionViewData)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //method is called by the viewModel when it has new data
    func reloadCollectionViewData(){
        
        mImageListCollentionView.reloadData()
        
        if viewModel.finished {
            loadingStatus = .finished
        }
    }
    
    private func configureCollectionView() {
        
        let size  = self.mImageListCollentionView.frame.size
        collectionViewSizeCalculator.rowMaximumHeight = size.height/2
        
        mImageListCollentionView.collectionViewLayout = layout
        
        SKPhotoBrowserOptions.displayAction = false
        SKPhotoBrowserOptions.displayStatusbar = true
    }
    
    
    func loadMoreInCollectionView() {
        
        if !viewModel.isLoadingData && !viewModel.finished {
            viewModel.retrieveData(page:viewModel.getCountPage())
        }
    }
    

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ImageListViewController: UICollectionViewDataSource,GreedoCollectionViewLayoutDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return viewModel.numberOfSectionsInCollectionView()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfItemsInSection()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(indexPath.row == viewModel.numberOfItemsInSection()-1){
            if loadingStatus == .haveMore {
                self.perform(#selector(ImageListViewController.loadMoreInCollectionView), with: nil, afterDelay: 0)
            }
        }
        
        return viewModel.setUpCollectionViewCell(indexPath: indexPath as NSIndexPath, collectionView: mImageListCollentionView)
        
    }
    
    func greedoCollectionViewLayout(_ layout: GreedoCollectionViewLayout!, originalImageSizeAt indexPath: IndexPath!) -> CGSize {
        
        return CGSize(width: 1, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionViewSizeCalculator.sizeForPhoto(at: indexPath as IndexPath!)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var footerView:LoadMoreCollectionReusableView!
        
        if (kind ==  UICollectionElementKindSectionFooter) && (loadingStatus != .finished){
            footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.kLoadMoreVerticalCollectionFooterViewCellIdentifier, for: indexPath) as! LoadMoreCollectionReusableView
        }
        else{
            footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.kLoadMoreVerticalCollectionFooterViewCellIdentifier, for: indexPath) as! LoadMoreCollectionReusableView
        }
        
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return (loadingStatus == .finished) ? CGSize.zero : CGSize(width: self.view.frame.width, height: 100)
        
    }
    
}

extension ImageListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageViewCollectionViewCell else {
            return
        }
        guard let originImage = cell.mImageView.image else {
            return
        }
        
        let browser = SKPhotoBrowser(originImage: originImage, photos: viewModel.imagesPreview, animatedFromView: cell)
        browser.initializePageIndex(indexPath.row)
        browser.delegate = self
        
        present(browser, animated: true, completion: {})
        
    }
    
}

extension ImageListViewController: SKPhotoBrowserDelegate {
    
    func didShowPhotoAtIndex(_ index: Int) {
        mImageListCollentionView.visibleCells.forEach({$0.isHidden = false})
        mImageListCollentionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
    }
    
    func willDismissAtPageIndex(_ index: Int) {
        mImageListCollentionView.visibleCells.forEach({$0.isHidden = false})
        mImageListCollentionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = true
    }
    
    func willShowActionSheet(_ photoIndex: Int) {
        // do some handle if you need
    }
    
    func didDismissAtPageIndex(_ index: Int) {
        mImageListCollentionView.cellForItem(at: IndexPath(item: index, section: 0))?.isHidden = false
    }
    
    func didDismissActionSheetWithButtonIndex(_ buttonIndex: Int, photoIndex: Int) {
        // handle dismissing custom actions
    }
    
    func removePhoto(index: Int, reload: (() -> Void)) {
        reload()
    }
    
    func viewForPhoto(_ browser: SKPhotoBrowser, index: Int) -> UIView? {
        return mImageListCollentionView.cellForItem(at: IndexPath(item: index, section: 0))
    }
}


