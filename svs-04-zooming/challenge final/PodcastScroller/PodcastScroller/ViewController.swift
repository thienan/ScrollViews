//
//  ViewController.swift
//  PodcastScroller
//
//  Created by Brian on 2/9/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView.frame.size = (imageView.image?.size)!
    scrollView.delegate = self
    scrollView.minimumZoomScale = 0.1
    scrollView.maximumZoomScale = 3.0
    scrollView.zoomScale = 1.0
    
    setZoomParametersForSize(scrollView.bounds.size)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillLayoutSubviews() {
    setZoomParametersForSize(scrollView.bounds.size)
  }
  
  func setZoomParametersForSize(_ scrollViewSize: CGSize) {
    let imageSize = imageView.bounds.size
    
    let widthScale = scrollViewSize.width / imageSize.width
    let heightScale = scrollViewSize.height / imageSize.height
    let minScale = min(widthScale, heightScale)
    
    scrollView.minimumZoomScale = minScale
    scrollView.maximumZoomScale = 3.0
    scrollView.zoomScale = minScale
  }
  
}

extension ViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
}

