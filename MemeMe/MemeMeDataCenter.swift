//
//  DataCenter.swift
//  MemeMe
//
//  Created by 김필환 on 2017. 1. 28..
//  Copyright © 2017년 김필환. All rights reserved.
//

import Foundation

let dataCenter:MemeMeDataCenter = MemeMeDataCenter()
let fileName = "MemeMe.dat"

class MemeMeDataCenter {
    
    var memes:[Meme] = []
    
    init() {
        if FileManager.default.fileExists(atPath: self.filePath) {
            // read
            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath) as? [Meme] {
                memes += unarchArray
            }
        }
    }
    
    func saveMeme(_ meme:Meme) {
        if let index = memes.index(of: meme) {
            memes[index] = meme
        } else {
            memes.append(meme)
        }
        
        save()
    }
    
    func removeMeme(_ meme:Meme) {
        if let index = memes.index(of: meme) {
            memes.remove(at: index)
        }
        
        save()
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
