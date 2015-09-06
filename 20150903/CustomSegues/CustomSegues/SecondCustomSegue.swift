//
//  SecondCustomSegue.swift
//  CustomSegues
//
//  Created by Stoner Wang on 15/9/6.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit

class SecondCustomSegue: UIStoryboardSegue {

    override func perform() {
        let firstVCView = self.sourceViewController.view as UIView!
        let thirdVCView = self.destinationViewController.view as UIView!
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(thirdVCView, belowSubview: firstVCView)
        
        thirdVCView.transform = CGAffineTransformScale(thirdVCView.transform, 0.001, 0.001)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            firstVCView.transform = CGAffineTransformScale(thirdVCView.transform, 0.001, 0.001)
        }, completion: { (finished: Bool) -> Void in
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                thirdVCView.transform = CGAffineTransformIdentity
            }, completion: { (Finished: Bool) -> Void in
                firstVCView.transform = CGAffineTransformIdentity
                self.sourceViewController.presentViewController(self.destinationViewController, animated: false, completion: nil)
            })
        })
    }
    
}
