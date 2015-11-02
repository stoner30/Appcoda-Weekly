//
//  FirstCustomSegueUnwind.swift
//  CustomSegues
//
//  Created by Stoner Wang on 15/9/6.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit

class FirstCustomSegueUnwind: UIStoryboardSegue {

    override func perform() {
        let secondVCView = self.sourceViewController.view as UIView!
        let firstVCView = self.destinationViewController.view as UIView!
        
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(firstVCView, aboveSubview: secondVCView)
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            firstVCView.frame = CGRectOffset(firstVCView.frame, 0.0, screenHeight)
            secondVCView.frame = CGRectOffset(secondVCView.frame, 0.0, screenHeight)
        }, completion: { (finished: Bool) -> Void in
            self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
        })
    }
    
}
