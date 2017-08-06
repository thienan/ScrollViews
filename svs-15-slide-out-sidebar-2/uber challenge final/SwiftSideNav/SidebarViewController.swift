/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class SidebarViewController: UIViewController {
  var leftViewController: UIViewController!
  var mainViewController: UIViewController!
  var rightViewController: UIViewController!

  var overlap: CGFloat!
  var scrollView: UIScrollView!
  var firstTime = true
  
  required init(coder aDecoder: NSCoder) {
    assert(false, "Use init(leftViewController:mainViewController:overlap:)")
    super.init(coder: aDecoder)!
  }

  init(leftViewController: UIViewController, mainViewController: UIViewController, rightViewController: UIViewController, overlap: CGFloat) {
    self.leftViewController = leftViewController
    self.mainViewController = mainViewController
    self.rightViewController = rightViewController
    self.overlap = overlap

    super.init(nibName: nil, bundle: nil)

    self.view.backgroundColor = UIColor.black

    setupScrollView()
    setupViewControllers()
  }

  override func viewDidLayoutSubviews() {
    if firstTime {
      firstTime = false
      closeMenuAnimated(false)
    }
  }

  func setupScrollView() {
    scrollView = UIScrollView()
    scrollView.isPagingEnabled = true
    scrollView.bounces = false
    scrollView.clipsToBounds = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(scrollView)

    scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -overlap)

    let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]", options: [], metrics: nil, views: ["scrollView": scrollView])
    let scrollWidthConstraint = NSLayoutConstraint(
      item: scrollView,
      attribute: .width,
      relatedBy: .equal,
      toItem: view,
      attribute: .width,
      multiplier: 1.0, constant: -overlap)
    let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [], metrics: nil, views: ["scrollView": scrollView])
    NSLayoutConstraint.activate(horizontalConstraints + verticalConstraints + [scrollWidthConstraint])

    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(SidebarViewController.viewTapped(_:)))
    tapRecognizer.delegate = self
    view.addGestureRecognizer(tapRecognizer)
  }

  func viewTapped(_ tapRecognizer: UITapGestureRecognizer) {
    closeMenuAnimated(true)
  }

  func setupViewControllers() {
    addViewController(leftViewController)
    addViewController(mainViewController)
    addViewController(rightViewController)

    addShadowToView(mainViewController.view)

    let views = ["left": leftViewController.view, "main": mainViewController.view, "right": rightViewController.view, "outer": view]
    let horizontalConstraints = NSLayoutConstraint.constraints(
      withVisualFormat: "|[left][main(==outer)][right]|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views)
    let leftWidthConstraint = NSLayoutConstraint(
      item: leftViewController.view,
      attribute: .width,
      relatedBy: .equal,
      toItem: view,
      attribute: .width,
      multiplier: 1.0, constant: -overlap)
    let rightWidthConstraint = NSLayoutConstraint(
      item: rightViewController.view,
      attribute: .width,
      relatedBy: .equal,
      toItem: view,
      attribute: .width,
      multiplier: 1.0, constant: -overlap)
    let verticalConstraints = NSLayoutConstraint.constraints(
      withVisualFormat: "V:|[main(==outer)]|", options: [], metrics: nil, views: views)
    NSLayoutConstraint.activate(horizontalConstraints + verticalConstraints + [leftWidthConstraint,rightWidthConstraint])

    view.addGestureRecognizer(scrollView.panGestureRecognizer)
  }

  func closeMenuAnimated(_ animated: Bool) {
    scrollView.setContentOffset(CGPoint(x: scrollView.frame.width, y: 0), animated: animated)
  }

  func leftMenuIsOpen() -> Bool {
    return scrollView.contentOffset.x == 0
  }

  func rightMenuIsOpen() -> Bool {
    return scrollView.contentOffset.x == scrollView.frame.width * 2
  }

  func openLeftMenuAnimated(_ animated: Bool) {
    scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
  }

  func toggleLeftMenuAnimated(_ animated: Bool) {
    if leftMenuIsOpen() {
      closeMenuAnimated(animated)
    } else {
      openLeftMenuAnimated(animated)
    }
  }

  fileprivate func addViewController(_ viewController: UIViewController) {
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    scrollView.addSubview(viewController.view)
    addChildViewController(viewController)
    viewController.didMove(toParentViewController: self)
  }

  fileprivate func addShadowToView(_ destView: UIView) {
    destView.layer.shadowPath = UIBezierPath(rect: destView.bounds).cgPath
    destView.layer.shadowRadius = 2.5
    destView.layer.shadowOffset = CGSize(width: 0, height: 0)
    destView.layer.shadowOpacity = 1.0
    destView.layer.shadowColor = UIColor.black.cgColor
  }
}

extension SidebarViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    let tapLocation = touch.location(in: view)
    let tapWasInRightOverlapArea = tapLocation.x >= view.bounds.width - overlap
    let tapWasInLeftOverlapArea = tapLocation.x <= overlap

    return
      (tapWasInRightOverlapArea && leftMenuIsOpen()) ||
      (tapWasInLeftOverlapArea && rightMenuIsOpen())
  }
}
