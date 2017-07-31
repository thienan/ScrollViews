//
//  RWScrollView.swift
//  CustomScrollView
//
//  Created by Brian Douglas Moakley on 3/7/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class RWScrollView: UIView {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panView(with:)))
    addGestureRecognizer(panGesture)
  }
  
  func panView(with gestureRecognizer: UIPanGestureRecognizer) {
    let translation = gestureRecognizer.translation(in: self)
    UIView.animate(withDuration: 0.20) {
      self.bounds.origin.y = self.bounds.origin.y - translation.y
    }
    
    gestureRecognizer.setTranslation(CGPoint.zero, in: self)
  }
  

}
