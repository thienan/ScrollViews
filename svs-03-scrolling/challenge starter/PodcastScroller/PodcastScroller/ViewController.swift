//
//  ViewController.swift
//  PodcastScroller
//
//  Created by Brian on 2/9/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var imageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()

    scrollView.contentSize = (imageView.image?.size)!
    
    }


}

