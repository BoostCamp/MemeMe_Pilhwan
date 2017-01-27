//
//  Meme.swift
//  MemeMe
//
//  Created by 김필환 on 2017. 1. 26..
//  Copyright © 2017년 김필환. All rights reserved.
//

import UIKit

class Meme : NSObject, NSCoding {
    var topText: String!
    var bottomText: String!
    var originalImage: UIImage!
    var memedImage: UIImage!
    
    init(topText:String!, bottomText:String!, originalImage:UIImage!, memedImage:UIImage!) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.topText = aDecoder.decodeObject(forKey: "topText") as? String
        self.bottomText = aDecoder.decodeObject(forKey: "bottomText") as? String
        self.originalImage = aDecoder.decodeObject(forKey: "originalImage") as? UIImage
        self.memedImage = aDecoder.decodeObject(forKey: "memedImage") as? UIImage
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        
        if let topText = self.topText {
            aCoder.encode(topText, forKey: "topText")
        }
        
        if let bottomText = self.bottomText {
            aCoder.encode(bottomText, forKey: "bottomText")
        }
        
        if let originalImage = self.originalImage {
            aCoder.encode(originalImage, forKey: "originalImage")
        }
        
        if let memedImage = self.memedImage {
            aCoder.encode(memedImage, forKey: "memedImage")
        }
    }
}
