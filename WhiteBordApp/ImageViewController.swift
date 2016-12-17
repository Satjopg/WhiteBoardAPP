//
//  ImageViewController.swift
//  WhiteBordApp
//
//  Created by Satoru Murakami on 2016/11/27.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var DetailImage: UIImageView!
    @IBOutlet weak var anaButton: UIButton!
    var Image = UIImage()
    var flg = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DetailImage.image = Image
        DetailImage.contentMode = UIViewContentMode.scaleAspectFit
        DetailImage.isUserInteractionEnabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if flg == 1 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            flg = 0
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            flg = 1
        }
    }

    @IBAction func analyticsButton(_ sender: AnyObject) {
        postImage(image: Image)
    }
}
