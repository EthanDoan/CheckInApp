//
//  UINavigationControllerExtension.swift
//  UITabBarControllerProgrammatically
//
//  Created by Doan Van Phuong on 10/31/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    @available(iOS 13.0, *)
    func setNavigationBarBackgroundColor(_ color: UIColor) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = color;
        navBarAppearance.shadowImage = nil;//line
        navBarAppearance.shadowColor = nil;//line
        self.navigationBar.standardAppearance = navBarAppearance
        self.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    @available(iOS 13.0, *)
    func transparentBackgroundColor() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.shadowImage = nil;//line
        navBarAppearance.shadowColor = nil;//line
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationBar.standardAppearance = navBarAppearance
        self.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func navigationBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.size.height + self.navigationBar.frame.size.height
    }
    
    func removeViewControllerFromStack<T:UIViewController>(viewController: T) {
        var newStack  = [UIViewController]()
        let vcs = self.viewControllers
        for vc in vcs {
            if vc.isKind(of: T.self) {
                newStack.append(vc)
            }
        }
        viewControllers = newStack
    }
    
}

public extension UINavigationController {
    
    func ph_getCurrentViewController() -> UIViewController? {
        return viewControllers.last
    }
    
    func ph_replaceCurrentViewController(_ viewController: UIViewController, animated: Bool) {
        var editableViewControllers = viewControllers
        editableViewControllers.removeLast()
        editableViewControllers.append(viewController)
        setViewControllers(editableViewControllers, animated: animated)
    }
    
    func ph_pushOrReplaceToFirstViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 1 {
            // ph_replaceCurrentViewController(viewController, animated: animated)
            ph_pushArrayViewControllerToFirstViewController([viewController], animated: animated)
        } else {
            pushViewController(viewController, animated: animated)
        }
    }
    
    func ph_popToFirstViewControllerWithAnimated(_ animated: Bool) {
        if viewControllers.count > 1 {
            popToViewController(viewControllers[1], animated: animated)
        }
    }
    
    func ph_pushArrayViewControllerToFirstViewController(_ arrViewController: [UIViewController], animated: Bool) {
        var editableViewControllers = [UIViewController]()
        editableViewControllers.append(viewControllers[0])
        editableViewControllers.append(contentsOf: arrViewController)
        setViewControllers(editableViewControllers, animated: animated)
    }
    
    // MARK: - Fade Animation
    // MARK: -
    
    func ph_pushFadeViewController(_ viewController: UIViewController, duration: Double = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.view.layer.add(transition, forKey: nil)
        // -- Push --
        self.pushViewController(viewController, animated: false)
    }
    
    func ph_popFadeViewController(_ duration: Double = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.view.layer.add(transition, forKey: nil)
        // -- Pop --
        self.popViewController(animated: false)
    }
    
    func ph_popFadeToRootViewController(_ duration: Double = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.view.layer.add(transition, forKey: nil)
        // -- Pop --
        self.popToRootViewController(animated: false)
    }
    
    func ph_popFadeToFirstViewController(_ duration: Double = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.view.layer.add(transition, forKey: nil)
        // -- Pop --
        self.ph_popToFirstViewControllerWithAnimated(false)
    }
    
    func ph_replaceFadeCurrentViewController(withViewController controller: UIViewController, duration seconds: Double = 0.3) {
        self.ph_replaceFadeCountViewControllers(1, withViewController: controller, duration: seconds)
    }
    
    func ph_replaceFadeCountViewControllers(_ nums: Int, withViewController controller: UIViewController, duration seconds: Double) {
        var controllers = self.viewControllers;
        
        var controllerIndex = controllers.count - nums
        if controllerIndex < 0 {
            controllerIndex = 0
        }
        
        controllers.insert(controller, at: controllerIndex)
        self.setViewControllers(controllers, animated: false)
        
        let transition = CATransition();
        transition.duration = seconds;
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade;
        self.view.layer.add(transition, forKey: nil)
        
        self.popToViewController(controller, animated: false)
        
    }
    
    /// SwifterSwift: Pop ViewController with completion handler.
    ///
    /// - Parameter completion: optional completion handler (default is nil).
    func ph_popViewController(_ completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: true)
        CATransaction.commit()
    }
    
    func ph_popFadeViewController(_ completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.view.layer.add(transition, forKey: nil)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: false)
        CATransaction.commit()
    }
    
    /// SwifterSwift: Push ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - viewController: viewController to push.
    ///   - completion: optional completion handler (default is nil).
    func ph_pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
    /// SwifterSwift: Make navigation controller's navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    func ph_makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
    
}
