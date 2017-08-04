//
//  ViewController.swift
//  RWDevConRegistration
//
//  Created by Brian on 2/16/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func keyboardWillShow(notification: Notification) {
    adjustInsetForKeyboardShow(show: true, notification: notification)
  }
  
  func keyboardWillHide(notification: Notification) {
    adjustInsetForKeyboardShow(show: false, notification: notification)
  }
  
  func adjustInsetForKeyboardShow(show: Bool, notification: Notification) {
    let userInfo = notification.userInfo ?? [:]
    let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    let adjustmentHeight = (keyboardFrame.height * (show ? 1 : -1))
  
    scrollView.contentInset.bottom += adjustmentHeight
    scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    
  }
}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}

