//
//  ViewController.swift
//  FrameVsBounds
//
//  Created by Greg Heo on 2014-11-16.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var innerView: UIView!
  
  @IBOutlet weak var frameSlider: UISlider!
  @IBOutlet weak var boundsSlider: UISlider!
  @IBOutlet weak var frameYSlider: UISlider!
  @IBOutlet weak var boundsYSlider: UISlider!

  @IBOutlet weak var frameOriginLabel: UILabel!
  @IBOutlet weak var boundsOriginLabel: UILabel!
  @IBOutlet weak var frameYOriginLabel: UILabel!
  @IBOutlet weak var boundsYOriginLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    frameSlider.value = Float(containerView.frame.origin.x)
    boundsSlider.value = Float(containerView.bounds.origin.x)

    frameYSlider.value = Float(containerView.frame.origin.y)
    boundsYSlider.value = Float(containerView.bounds.origin.y)

    updateValues()
  }

  @IBAction func frameSliderChanged(_ sender: AnyObject) {
    updateValues()
  }

  @IBAction func boundsSliderChanged(_ sender: AnyObject) {
    updateValues()
  }


  @IBAction func frameYSliderChanged(_ sender: AnyObject) {
    updateValues()
  }

  @IBAction func boundsYSliderChanged(_ sender: AnyObject) {
    updateValues()
  }

  fileprivate func updateValues() {
    frameOriginLabel.text = "Frame x origin = \(Int(containerView.frame.origin.x))"
    boundsOriginLabel.text = "Bounds x origin = \(Int(containerView.bounds.origin.x))"
    frameYOriginLabel.text = "Frame y origin = \(Int(containerView.frame.origin.y))"
    boundsYOriginLabel.text = "Bounds y origin = \(Int(containerView.bounds.origin.y))"
  }

}
