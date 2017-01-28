//
//  ViewController.swift
//  MemeMe
//
//  Created by 김필환 on 2017. 1. 25..
//  Copyright © 2017년 김필환. All rights reserved.
//

import UIKit

class MemeMeEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var photoLibButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    var meme = Meme()
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: 5.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        
        loadMeme(meme)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        photoLibButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        
        if imageView != nil, (imageView.image != nil) {
            shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMeme(_ meme:Meme) {
        if let image = meme.originalImage {
            imageView.image = image
        }
        if let topText = meme.topText {
            topTextField.text = topText
        }
        if let bottomText = meme.bottomText {
            bottomTextField.text = bottomText
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
        
    }
    
    func keyboardWillHide(_ notification:Notification) {
        if bottomTextField.isFirstResponder{
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func save(_ memedImage: UIImage) {
        
        if let topText = topTextField.text {
            meme.topText = topText
        }
        if let bottomText = bottomTextField.text {
            meme.bottomText = bottomText
        }
        if let originalImage = imageView.image {
            meme.originalImage = originalImage
        }
        meme.memedImage = memedImage
        
        dataCenter.saveMeme(meme)
        
        dismiss(animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }

    @IBAction func cancel(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Would you like to exit in edit mode?", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Exit", style: .default) { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
            }
        )
        alertController.addAction(UIAlertAction(title: "No", style: .default) { (action: UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
            }
        )
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func share(_ sender: Any) {
        let memedImage = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        //BUG FIX Start: UIActivityViewController in Swift Crashes on iPad
        if let popoverPresentationController = activityViewController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
        }
        //BUG FIX End: UIActivityViewController in Swift Crashes on iPad
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save(memedImage)
            }
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }

}

