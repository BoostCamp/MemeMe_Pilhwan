//
//  DataCenter.swift
//  MemeMe
//
//  Created by 김필환 on 2017. 1. 28..
//  Copyright © 2017년 김필환. All rights reserved.
//

import Foundation

let dataCenter:DataCenter = DataCenter()
let fileName = "MemeMe.dat"

class DataCenter {
    
    var memes:[Meme] = []
    
    init() {
        if FileManager.default.fileExists(atPath: self.filePath) {
            // read
            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath) as? [Meme] {
                memes += unarchArray
            }
        }
    }
    
    func appendMeme(_ meme:Meme) {
        memes.append(meme)
    }
    
    func removeMeme(_ meme:Meme) {
        if let index = memes.index(of: meme) {
            memes.remove(at: index)
        }
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(self.memes, toFile: self.filePath)
    }
    
    var filePath:String { get {
            let documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDir + fileName
        }
    }
}
