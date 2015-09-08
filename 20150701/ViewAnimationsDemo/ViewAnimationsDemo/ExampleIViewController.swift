//
//  ExampleIViewController.swift
//  ViewAnimationsDemo
//
//  Created by Stoner Wang on 15/9/7.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit

class ExampleIViewController: UIViewController {

    @IBOutlet weak var centerAlignUsername: NSLayoutConstraint!
    @IBOutlet weak var centerAlignPassword: NSLayoutConstraint!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        centerAlignUsername.constant += view.bounds.width
        centerAlignPassword.constant += view.bounds.width
        loginButton.alpha = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
            self.centerAlignUsername.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.3, options: .CurveEaseOut, animations: {
            self.centerAlignPassword.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, options: .CurveEaseOut, animations: {
            self.loginButton.alpha = 1
        }, completion: nil)
    }
    
    @IBAction func login(sender: UIButton) {
        let bounds = self.loginButton.bounds
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 20, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.loginButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            self.loginButton.enabled = false
        }, completion: {
            finished in
            self.loginButton.bounds = CGRect(x: bounds.origin.x + 20, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
            self.loginButton.enabled = true
        })
    }

}
