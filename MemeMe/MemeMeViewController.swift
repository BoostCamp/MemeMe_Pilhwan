//
//  ViewController.swift
//  MemeMe
//
//  Created by 김필환 on 2017. 1. 25..
//  Copyright © 2017년 김필환. All rights reserved.
//

import UIKit

class MemeMeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
