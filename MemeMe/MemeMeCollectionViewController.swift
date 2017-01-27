//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by 김필환 on 2017. 1. 26..
//  Copyright © 2017년 김필환. All rights reserved.
//

import UIKit

class MemeMeCollectionViewController: UICollectionViewController {

    var memes: [Meme]!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        memes = dataCenter.memes
        collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeMeCollectionCell", for: indexPath) as! MemeMeCollectionViewCell
        let meme = memes[indexPath.item]
        cell.imageView.image = meme.memedImage

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showDetail") {
            if let viewController = segue.destination as? MemeMeDetailViewController, let indexPath = collectionView?.indexPathsForSelectedItems?.first {
                let meme = memes[(indexPath as NSIndexPath).row]
                viewController.meme = meme
            }
        }
    }

}
