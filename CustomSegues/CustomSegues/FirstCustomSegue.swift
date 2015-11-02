//
//  FirstCustomSegue.swift
//  CustomSegues
//
//  Created by Stoner Wang on 15/9/6.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit

class FirstCustomSegue: UIStoryboardSegue {

    override func perform() {
        let firstVCView = self.sourceViewController.view as UIView!
        let secondVCView = self.destinationViewController.view as UIView!
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        secondVCView.frame = CGRectMake(0.0, screenHeight, screenWidth, screenHeight)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(secondVCView, aboveSubview: firstVCView)
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            firstVCView.frame = CGRectOffset(firstVCView.frame, 0.0, -screenHeight)
            secondVCView.frame = CGRectOffset(secondVCView.frame, 0.0, -screenHeight)
        }, completion: { (finished: Bool) -> Void in
            self.sourceViewController.presentViewController(self.destinationViewController, animated: false, completion: nil)
        })
    }
    
}
