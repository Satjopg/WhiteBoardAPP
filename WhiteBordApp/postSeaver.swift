//
//  postSeaver.swift
//  WhiteBordApp
//
//  Created by Satoru Murakami on 2016/11/29.
//  Copyright © 2016年 Satoru Murakami. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let env = ProcessInfo.processInfo.environment
let YOUR_API_KEY = env["API_KEY"]! as String

func postImage(image:UIImage) {
    let imageBase64:String = base64EncodeImage(image)
    let headers = ["Content-Type":"application/json"]
    let parameters:[String:Any] = [
        "requests": [
            "image": [
                "content":imageBase64
            ],
            "features":[
                [
                    "type": "TEXT_DETECTION",
                    "maxResults": 10
                ]
            ]
        ]
    ]
    Alamofire.request("https://vision.googleapis.com/v1/images:annotate?key="+YOUR_API_KEY, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
        guard let object = response.result.value else {
            return
        }
        let json = JSON(object)
        print(json)
        
    }
}

func base64EncodeImage(_ image: UIImage) -> String {
    var imagedata = UIImagePNGRepresentation(image)
    // Resize the image if it exceeds the 2MB API limit
    if ((imagedata?.count)! > 2097152) {
        let oldSize: CGSize = image.size
        let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
        imagedata = resizeImage(newSize, image: image)
    }
    
    return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
}

func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
    UIGraphicsBeginImageContext(imageSize)
    image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    let resizedImage = UIImagePNGRepresentation(newImage!)
    UIGraphicsEndImageContext()
    return resizedImage!
}

