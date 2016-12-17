//
//  photoCollectionCell.swift
//  WhiteBordApp
//
//  Created by Satoru Murakami on 2016/11/27.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class photoCollectionCell:UICollectionViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    func cell_set(image: UIImage){
        photoImage.image = image
    }
}
