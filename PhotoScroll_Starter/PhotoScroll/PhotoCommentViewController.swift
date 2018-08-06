//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by Deep Thought on 2017/7/16.
//  Copyright © 2017年 raywenderlich. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    
    var photoName: String?
    var photoIndex: Int!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photoName = photoName {
            imageView.image = UIImage(named: photoName)
        }
      
      NotificationCenter.default.addObserver(self, selector: #selector(PhotoCommentViewController.keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(PhotoCommentViewController.keyboardWillHide(_:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
      
      
    }
    deinit {
      NotificationCenter.default.removeObserver(self)
    }
    func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
      let userInfo = notification.userInfo ?? [:]
      let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
      let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
      scrollView.contentInset.bottom += adjustmentHeight
      scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    @objc func keyboardWillShow(_ notification: Notification) {
      adjustInsetForKeyboardShow(true, notification: notification)
    }
    @objc func keyboardWillHide(_ notification: Notification) {
      adjustInsetForKeyboardShow(false, notification: notification)
    }

    @IBAction func hideKeyboard(_ sender: Any) {
        nameTextField.endEditing(true)
    }
  
    @IBAction func openZoomingController(_ sender: Any) {
        self.performSegue(withIdentifier: "zooming", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier,
        let zoomedPhotoViewController = segue.destination as? ZoomedPhotoViewController,
            id == "zooming" {
            zoomedPhotoViewController.photoName = photoName
        }
    }

}
