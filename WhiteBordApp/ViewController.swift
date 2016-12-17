//
//  ViewController.swift
//  WhiteBordApp
//
//  Created by Satoru Murakami on 2016/11/26.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var photoAsset = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization { (PHAuthorizationStatus) in }
        
        get_camerearoll()
        photoCollectionView.register(photoCollectionCell.self, forCellWithReuseIdentifier: "cell")
        photoCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:photoCollectionCell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! photoCollectionCell
        let image = changeUIimage(asset: photoAsset[indexPath.row])
        cell.cell_set(image: image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoAsset.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize:CGFloat = self.view.frame.size.width/4-3
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize+1)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func get_camerearoll() {
        
        self.photoAsset = []
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let assets:PHFetchResult = PHAsset.fetchAssets(with: .image, options: options)
        assets.enumerateObjects(options: .init(rawValue: 0)) { (asset, index, stop) in
            self.photoAsset.append(asset)
        }
    }
    
    func changeUIimage(asset:PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var photo = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 70, height: 70), contentMode: .aspectFit, options: option) { (result, info) in
            photo = result!
        }
        return photo
    }
    
    func detailphoto(asset:PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var photo = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 300, height: 600), contentMode: .aspectFit, options: option) { (result, info) in
            photo = result!
        }
        return photo
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailImageSegue" {
            let nextview = segue.destination as! ImageViewController
            let index = photoCollectionView.indexPathsForSelectedItems?.first
            let detailImage = detailphoto(asset: photoAsset[(index?.row)!])
            nextview.Image = detailImage
        }
    }
}
