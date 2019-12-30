//
//  UIViewExtensions.swift
//  PropzySam
//
//  Created by Doan Van Phuong on 8/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
//import MBProgressHUD
//import Lottie

public enum GradientType: Int {
    case vertical = 0
    case horizontal = 1
}

extension UIView {
    
    // add a gradient background color
    // should be called from viewDidLayoutSubviews()
    func setGradientBackgroundColor(colors: [UIColor], type: GradientType = .vertical) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [colors[0].cgColor, colors[1].cgColor]
        if type == .horizontal {
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        }
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func currentViewController() -> UIViewController? {
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while currentController.presentedViewController != nil {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
    }
    
    func animateY(newY: CGFloat, animTime: CGFloat, closure:@escaping (Bool)->Void) {
        let xPosition = self.frame.origin.x
        let height = self.frame.size.height
        let width = self.frame.size.width
        UIView.animate(withDuration: TimeInterval(animTime), delay: 0, options: [.curveEaseInOut], animations: {
            self.frame = CGRect(x: xPosition, y: newY, width: width, height: height)
        }, completion: closure)
    }
    
//    func showLoadingView(text: String, backgroundColor: UIColor) {
//        let loadingHud = MBProgressHUD.showAdded(to: self, animated: true)
//        loadingHud.contentColor = UIColor.APP_OGRANGE
//        loadingHud.bezelView.backgroundColor = UIColor.clear
//        loadingHud.label.font = UIFont.init(name: "Helvetica", size: 12)
//        loadingHud.label.text = text
//        loadingHud.backgroundView.backgroundColor = backgroundColor
//    }
    
//    func hideLoadingView(animated: Bool) {
//        for view in self.subviews {
//            if view.isKind(of: MBProgressHUD.self) {
//                let loadingHud = view as! MBProgressHUD
//                loadingHud.hide(animated: animated)
//            }
//        }
//    }
    
//    func showLoadingLOTAnimationView() {
//        let containerView = UIView(frame: self.bounds)
//        containerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
//        containerView.tag = 2000
//        self.addSubview(containerView)
//        let lottieAnimView = AnimationView(name: "ae_loading")
//        lottieAnimView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        lottieAnimView.backgroundColor = UIColor.clear
//        lottieAnimView.contentMode = .scaleAspectFit
//        containerView.addSubview(lottieAnimView)
//        lottieAnimView.center = containerView.center
//        lottieAnimView.loopMode = .loop
//        lottieAnimView.play()
//    }
    
//    func hideLoadingLOTAnimationView() {
//        for view in self.subviews {
//            if view.tag == 2000 {
//                view.removeFromSuperview()
//            }
//        }
//    }
    
    func showNoDataImage() {
        let containerView = UIView(frame: self.bounds)
        containerView.backgroundColor = UIColor.white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 220, height: 180))
        imageView.image = UIImage(named: "img_empty_data")
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        self.addSubview(containerView)
    }
    
//    func screenshotImage() -> UIImage {
//        let scale: CGFloat = PH.isRetina() == true ? 2.0 : 1.0
//        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, scale)
//        let context = UIGraphicsGetCurrentContext();
//        self.layer.render(in: context!)
//        let screenShot = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return screenShot!
//    }
    
    func centerYtoSuperView(superView: UIView) {
        self.frame = CGRect(x: self.frame.origin.x, y: superView.frame.size.height / 2 - (self.frame.size.height/2), width: self.frame.size.width, height: self.frame.size.height)
    }
    
    func addTapGesture(tapNumber: Int, target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    func springAnimation() {
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(1.0), options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: { Void in()
        })
    }
    
    func isDisable() {
        if alpha == 0.3 && isUserInteractionEnabled == false {
            return
        }
        alpha = 0.3
        isUserInteractionEnabled = false
    }
    
    func isEnable() {
        alpha = 1.0
        isUserInteractionEnabled = true
    }
    
    //tao title view giong nhu tableview section header
//    func phTitleView(title: String, titleColor: UIColor, bgColor: UIColor) {
//        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50)
//        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 300, height: 50))
////        label.propzyTableViewSectionHeaderLabelStyle()
//        label.textAlignment = .left
//        label.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
//        label.alpha = 0.5
//        label.text = title
//        self.addSubview(label)
//        self.backgroundColor = bgColor
//    }
}

//layout constraints
extension UIView {
    
    func addConstraintsToSuperview(leadingOffset: CGFloat, topOffset: CGFloat, trailingOffset: CGFloat, bottomOffset: CGFloat) {
        guard superview != nil else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor,
                                 constant: leadingOffset).isActive = true
        topAnchor.constraint(equalTo: superview!.topAnchor,
                             constant: topOffset).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: trailingOffset).isActive = true
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: bottomOffset).isActive = true
    }
    
    func addConstraintsToFitSuperView() {
        let spView = self.superview
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: spView!.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: spView!.trailingAnchor),
            self.topAnchor.constraint(equalTo: spView!.topAnchor),
            self.bottomAnchor.constraint(equalTo: spView!.bottomAnchor)
            ])
    }
    
    func addConstraints(bottomOffset: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: superview!.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview!.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superview!.bottomAnchor),
            self.heightAnchor.constraint(equalToConstant: height)
            ])
    }
    
    func addConstaints(height: CGFloat, width: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func addConstraintCenterToSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: superview!.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview!.trailingAnchor),
            self.centerXAnchor.constraint(equalTo: superview!.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: superview!.centerYAnchor)
            ])
    }
    
    func getStatusBarHeight() -> CGFloat {
        var height: CGFloat = 0
        if #available(iOS 13.0, *) {
            height = self.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            // Fallback on earlier versions
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            height = statusBar.frame.size.height
        }
        return height
    }
    
}
