//
//  MenuTransitionManager.swift
//  SlideMenu
//
//  Created by Stoner Wang on 15/9/16.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit

class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {

    var duration = 0.5
    var isPresenting = false
    
    var snapshot: UIView? {
        didSet {
            if let _delegate = delegate {
                let tapGestureRecognizer = UITapGestureRecognizer(target: _delegate, action: "dismiss")
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
    
    var delegate: MenuTransitionManagerDelegate?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // 获得fromView、toView及container
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // 设定滑动转换
        let container = transitionContext.containerView()!
        let moveDown = CGAffineTransformMakeTranslation(0, container.frame.height - 150)
        let moveUp = CGAffineTransformMakeTranslation(0, -50)
        
        // 将两个视图加紧容器视图
        if isPresenting {
            toView.transform = moveUp
            snapshot = fromView.snapshotViewAfterScreenUpdates(true)
            container.addSubview(toView)
            container.addSubview(snapshot!)
        }
        
        // 执行动画
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.TransitionNone, animations: {
            if self.isPresenting {
                self.snapshot?.transform = moveDown
                toView.transform = CGAffineTransformIdentity
            } else {
                self.snapshot?.transform = CGAffineTransformIdentity
                fromView.transform = moveUp
            }
        }, completion: { finished in
            transitionContext.completeTransition(true)
            if !self.isPresenting {
                self.snapshot?.removeFromSuperview()
            }
        })
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
}

@objc protocol MenuTransitionManagerDelegate {
    func dismiss()
}
