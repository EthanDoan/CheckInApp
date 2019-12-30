//
//  UIViewControllerExtensions.swift
//  PropzySam
//
//  Created by Doan Van Phuong on 9/5/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SnapKit

extension UIViewController {
    
    func showNoResultAlert() {
        DispatchQueue.main.async {
            PHAlert.showNormalAlert("", message: "Chưa tìm thấy bất động sản trong khu vực đã chọn.", cancelTitle: "Đóng", otherTitle: nil, cancelAction: nil, otherAction: nil)
        }
    }
    
    func addChildViewController(childController: UIViewController, onView: UIView?) {
        var containerView = self.view
        if let onView = onView {
            containerView = onView
        }
        addChild(childController)
        containerView?.addSubview(childController.view)
        constrainViewEqual(containerView: containerView!, view: childController.view)
        childController.didMove(toParent: self)
    }
    
    func removeChildViewControllers() {
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
    }
    
    func constrainViewEqual(containerView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                        toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                           toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                         toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                          toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0)
        containerView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }
    
    func setTabbarHidden(bool: Bool) {
        self.tabBarController?.tabBar.isHidden = bool
    }
    
    func changeStatusBarBackgroundColor(color: UIColor!) {
        if #available(iOS 13.0, *) {
            //need navigation bar background to be transparent to see the effect
            let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
            let statusBarFrame = statusBarManager?.statusBarFrame
            let statusBarHeight = statusBarFrame!.size.height;
            let statusbarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: statusBarHeight))
            statusbarView.backgroundColor = color
            self.view.addSubview(statusbarView)
            statusbarView.snp.makeConstraints { (make) in
                make.top.equalTo(self.view.snp.top)
                make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
                make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
                make.height.equalTo(CGFloat(statusBarHeight))
            }
        } else {
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = color
            }
        }
    }
}

