//
//  TableViewController.swift
//  MemeMe
//
//  Created by 김필환 on 2017. 1. 26..
//  Copyright © 2017년 김필환. All rights reserved.
//

import UIKit

class MemeMeTableViewController: UITableViewController {
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        memes = dataCenter.memes
        tableView?.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeMeTableCell", for: indexPath)
        
        let meme = memes[(indexPath as NSIndexPath).row]
        if let topText = meme.topText, let bottomText = meme.bottomText {
            cell.textLabel!.text = "\(topText) \(bottomText)"
        }
        cell.imageView!.image = meme.originalImage
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showDetail") {
            if let viewController = segue.destination as? MemeMeDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
                let meme = memes[(indexPath as NSIndexPath).row]
                viewController.meme = meme
            }
        }
    }

}
