//
//  ThirdViewController.swift
//  CustomSegues
//
//  Created by Stoner Wang on 15/9/6.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        let swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "showFirstViewController")
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    func showFirstViewController() {
        self.performSegueWithIdentifier("idSecondSegueUnwind", sender: self)
    }
    
}
