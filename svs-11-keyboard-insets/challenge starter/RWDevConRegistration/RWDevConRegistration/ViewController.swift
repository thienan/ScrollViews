//
//  ViewController.swift
//  RWDevConRegistration
//
//  Created by Brian on 2/16/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyBoardWillShow(notification: NSNotification) {
        adjustInsetsForKeyboardShow(show: true, notification: notification)
    }
    
    func keyBoardWillHide(notification: NSNotification) {
        adjustInsetsForKeyboardShow(show: false, notification: notification)
    }
    
    func adjustInsetsForKeyboardShow(show: Bool, notification: NSNotification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let adjustmentHeight = ((keyboardFrame.height + 20) * (show ? 1 : -1))
        
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
}

