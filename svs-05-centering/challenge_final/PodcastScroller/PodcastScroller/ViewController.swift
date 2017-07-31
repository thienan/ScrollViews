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
    scrollView.zoomScale = scrollView.minimumZoomScale
    
    setZoomParametersForSize(scrollView.bounds.size)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillLayoutSubviews() {
    setZoomParametersForSize(scrollView.bounds.size)
    if scrollView.zoomScale < scrollView.minimumZoomScale {
      scrollView.zoomScale = scrollView.minimumZoomScale
    }
    recenterImage()
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
  
  func recenterImage() {
    let scrollViewSize = scrollView.bounds.size
    let imageSize = imageView.frame.size
    
    let horizontalSpace = imageSize.width < scrollViewSize.width ?
      (scrollViewSize.width - imageSize.width) / 2 : 0
    let verticalSpace = imageSize.height < scrollViewSize.height ?
      (scrollViewSize.height - imageSize.height) / 2 : 0
    
    scrollView.contentInset = UIEdgeInsets(top: verticalSpace,
                                           left: horizontalSpace,
                                           bottom: verticalSpace,
                                           right: horizontalSpace)
  }
  
}

extension ViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }

  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    recenterImage()
  }
  
}

