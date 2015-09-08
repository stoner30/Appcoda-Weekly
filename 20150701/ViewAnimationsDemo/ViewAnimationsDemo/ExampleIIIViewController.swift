//
//  ExampleIIIViewController.swift
//  ViewAnimationsDemo
//
//  Created by Stoner Wang on 15/9/7.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit

class ExampleIIIViewController: UIViewController {

    var alertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createView() {
        let alertWidth: CGFloat = view.bounds.width
        let alertHeight: CGFloat = view.bounds.height
        let alertViewFrame: CGRect = CGRectMake(0, 0, alertWidth, alertHeight)
        alertView = UIView(frame: alertViewFrame)
        alertView.backgroundColor = UIColor.redColor()
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, alertWidth, alertHeight / 2))
        imageView.image = UIImage(named: "bike_traveler")
        alertView.addSubview(imageView)
        
        let button = UIButton(type: UIButtonType.System)
        button.setTitle("Dismiss", forState: .Normal)
        button.backgroundColor = UIColor.whiteColor()
        let buttonWidth: CGFloat = alertWidth / 2
        let buttonHeight: CGFloat = 40
        button.frame = CGRectMake(alertView.center.x - buttonWidth / 2, alertView.center.y - buttonHeight / 2, buttonWidth, buttonHeight)
        button.addTarget(self, action: "dismissAlert", forControlEvents: UIControlEvents.TouchUpInside)
        
        alertView.addSubview(button)
        view.addSubview(alertView)
    }
    
    func dismissAlert() {
        let snapshot = alertView.snapshotViewAfterScreenUpdates(false)
        snapshot.frame = alertView.frame
        view.addSubview(snapshot)
        alertView.removeFromSuperview()
        
        let bounds = snapshot.bounds
        let smallFrame = CGRectInset(snapshot.frame, snapshot.frame.size.width / 4, snapshot.frame.size.height / 4)
        let finalFrame = CGRectOffset(smallFrame, 0, bounds.size.height)
        
        UIView.animateKeyframesWithDuration(4, delay: 0, options: .CalculationModeCubic, animations: {
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: {
                snapshot.frame = smallFrame
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5, animations: {
                snapshot.frame = finalFrame
            })
        }, completion: nil)
    }

}
