//
//  ViewController.swift
//  singleImagePicker
//
//  Created by Stu Almeleh on 11/16/15.
//  Copyright © 2015 Stu Almeleh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var fromAlbumButton: UIBarButtonItem!
    @IBOutlet weak var fromCameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    //define text attirbutes to be used
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -2
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //assign attributes to both text fields
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes

        
        //default text in both fields
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        //change scaling
        imagePickerView.contentMode = .ScaleAspectFit
        
        
        //disable the share button until imageview has an image
        //shareButton.enabled = false
        //shareButton.hidden = true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //from camera button will be disabled for devies w/o camera
        fromCameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
        
        if imagePickerView.image == nil {
            shareButton.enabled = false
            //shareButton.hidden = true
        }
        else {
            shareButton.enabled = true
            //shareButton.hidden = false
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //topTextField .becomeFirstResponder()
        //bottomTextField .becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //when clicking the From Album button
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //when clicking the from camera button
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    //When a user taps inside a textfield, the default text should clear.
    func textFieldDidBeginEditing(textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    //When a user presses return, the keyboard should be dismissed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    //UIImagePickerControllerDelegate functions
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        //if Meme Editor’s imageView has an image then enable & not hide share button
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //subscribe to keyboard show/hide
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //unsubscribe from keyboard show/hide
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //move frame with keyboard show/hide
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    func keyboardWillHide(notification: NSNotification){
        view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    
    
//    //SAVING THE MEME//
//    struct Meme {
//        var topText: String
//        var bottomText: String
//        var originalImage: UIImage
//        var memedImage: UIImage
//    }
    
    func generateMemedImage() -> UIImage {
        // TODO: Hide toolbar and navbar
        bottomToolbar.hidden = true
        
        // Render the current view to a Memed Image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        // TODO:  Show toolbar and navbar
        bottomToolbar.hidden = false
        return memedImage
    }
    
    
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        print("share button pressed")
        let memedImage = generateMemedImage()
        let ActivityVC = UIActivityViewController(activityItems:[memedImage], applicationActivities: nil)
        
        self.presentViewController(ActivityVC, animated: true, completion: nil)
        
        ActivityVC.completionWithItemsHandler = {
            (activity: String?, complete: Bool, items: [AnyObject]?, error: NSError?) -> Void in
            if complete {
                self.save()
                print("save function called")
                self.dismissViewControllerAnimated(true, completion: nil)
                print("view controller dismissed")
            }
        }
        
    }
    
    
    func save() {
        //create the meme
        let savedMeme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        print("created savedMeme")
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(savedMeme)
        print("added to appDelegate")
        print((UIApplication.sharedApplication().delegate as! AppDelegate).memes.count)
        
    }

    
    
    
}