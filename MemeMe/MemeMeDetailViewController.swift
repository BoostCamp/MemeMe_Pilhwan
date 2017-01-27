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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.imageView.image = meme.memedImage
        
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func removeMeme(_ sender: Any) {
        dataCenter.removeMeme(meme)
        dataCenter.save()
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
