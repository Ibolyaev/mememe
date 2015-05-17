//
//  ViewController.swift
//  MemeMe
//
//  Created by Игорь Боляев on 14.05.15.
//  Copyright (c) 2015 Igor Bolyaev. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
   
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var libraryButton: UIBarButtonItem!
    
    
    
    @IBOutlet weak var upperToolBar: UIToolbar!
    
    
    @IBOutlet weak var bottomToolBar: UIToolbar!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Making default settings according to the tasks rules
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : 0
        ]
        
        topTextField.text = "TOP"
        topTextField.delegate = self
        
        
        
        topTextField.defaultTextAttributes = memeTextAttributes
         topTextField.text = "TOP"
        topTextField.textAlignment = .Center
        
        bottomTextField.text = "BOTTOM"
        bottomTextField.delegate = self
        
        
        bottomTextField.defaultTextAttributes = memeTextAttributes
    
        bottomTextField.textAlignment = .Center
    }
    
    override func viewWillAppear(animated: Bool) {
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        //Make subscribe to notification when keyboard appear
        subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(animated: Bool) {
        self.unsubscribeFromKeyboardNotifications()
    }

    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            
            textField.text = ""
        }

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func keyBoardWillShow (notification: NSNotification) {
        
        if bottomTextField.isFirstResponder() {
        
            self.view.frame.origin.y -= getKeyboardHeight(notification)}
        
    }
    func keyboardWillHide (notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)}
        
    }
    

    func subscribeToKeyboardNotifications () {
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func getKeyboardHeight (notification: NSNotification) -> CGFloat {
    
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.image = image
        
        shareButton.enabled = true
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        imageView.image = nil
        self.dismissViewControllerAnimated(true, completion: nil)
    }

  
    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(picker, animated: true, completion: nil)
    }

    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        
        upperToolBar.hidden = true
        bottomToolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        upperToolBar.hidden = false
        bottomToolBar.hidden = false
        
        return memedImage
    }
    
    @IBAction func shareButtonPressed(sender: UIBarButtonItem) {
        
        var memedImage = generateMemedImage()
        
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {activity, completed, items, error in
            if completed {
                self.saveMeme()
                self.dismissViewControllerAnimated(true, completion: nil)
                return
            }
            
        }
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
       
        
    }
    
    func saveMeme() {
        //Create the meme
        var meme = Meme(topText:topTextField.text,bottomText:bottomTextField.text,originalImage:imageView.image!,memedImage: generateMemedImage())
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        
    }
    
   
}

