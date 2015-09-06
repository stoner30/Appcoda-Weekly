//
//  SecondCustomSegueUnwind.swift
//  CustomSegues
//
//  Created by Stoner Wang on 15/9/6.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit

class SecondCustomSegueUnwind: UIStoryboardSegue {

    override func perform() {
        let firstVCView = self.destinationViewController.view as UIView!
        let thirdVCView = self.sourceViewController.view as UIView!
        
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        firstVCView.frame = CGRectOffset(firstVCView.frame, 0.0, screenHeight)
        firstVCView.transform = CGAffineTransformScale(firstVCView.transform, 0.001, 0.001)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(firstVCView, aboveSubview: thirdVCView)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            thirdVCView.transform = CGAffineTransformScale(thirdVCView.transform, 0.001, 0.001)
            thirdVCView.frame = CGRectOffset(thirdVCView.frame, 0.0, -screenHeight)
            
            firstVCView.transform = CGAffineTransformIdentity
            firstVCView.frame = CGRectOffset(firstVCView.frame, 0.0, -screenHeight)
        }, completion: { (finished: Bool) -> Void in
            self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
        })
        
    }
    
}
