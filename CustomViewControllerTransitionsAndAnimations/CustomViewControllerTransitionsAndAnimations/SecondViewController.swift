//
//  SecondViewController.swift
//  CustomViewControllerTransitionsAndAnimations
//
//  Created by Stoner Wang on 15/9/7.
//  Copyright © 2015年 Stoner.Wong. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressDismiss(sender: AnyObject!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
