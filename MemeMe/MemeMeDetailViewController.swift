//
//  MemeMeDetailViewController.swift
//  MemeMe
//
//  Created by 김필환 on 2017. 1. 28..
//  Copyright © 2017년 김필환. All rights reserved.
//

import UIKit

class MemeMeDetailViewController: UIViewController {
    var meme: Meme!

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.imageView.image = meme.memedImage
        
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func removeMeme(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Would you like to remove this meme?", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Remove", style: .default) { (action: UIAlertAction!) in
            
            dataCenter.removeMeme(self.meme)
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            }
            }
        )
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default) { (action: UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
            }
        )
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showEdit") {
            if let destinationNavigationController = segue.destination as? UINavigationController,
                let viewController = destinationNavigationController.topViewController as? MemeMeViewController {
                
                viewController.meme = meme
            }
        }
    }
    

}
